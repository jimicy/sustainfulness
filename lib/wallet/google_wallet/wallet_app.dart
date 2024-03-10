import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';
import 'package:flutter_google_wallet/widget/add_to_google_wallet_button.dart';
import 'package:uuid/uuid.dart';

class WalletApp extends StatefulWidget {
  WalletApp({
    required this.cardImgUri,
    required this.language,
    required this.title,
    required this.message,
    super.key,
  });

  final flutterGoogleWalletPlugin = FlutterGoogleWalletPlugin();
  final String cardImgUri;
  final String language;
  final String message;
  final String title;

  @override
  State<WalletApp> createState() => _WalletAppButton();
}

class _WalletAppButton extends State<WalletApp> {
  late Future<bool> _isWalletAvailable;

  @override
  void initState() {
    super.initState();
    _isWalletAvailable = Future(() async {
      await widget.flutterGoogleWalletPlugin.initWalletClient();
      return widget.flutterGoogleWalletPlugin.getWalletApiAvailabilityStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<bool>(
                future: _isWalletAvailable,
                builder: (BuildContext context, AsyncSnapshot<bool> available) {
                  if (available.data == true) {
                    return AddToGoogleWalletButton(
                          locale: const Locale('en', 'EN'),
                          onPress: () {
                            widget.flutterGoogleWalletPlugin.savePasses(
                                jsonPass: generateJsonPass(
                                  '3388000000022316652', 
                                  widget.cardImgUri, 
                                  widget.language, 
                                  widget.title, 
                                  widget.message),
                                addToGoogleWalletRequestCode: 0,);
                          },
                      );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
    );
  }
}

//https://developers.google.com/wallet/reference/rest/v1/Jwt
class _WalletPayLoad {

  _WalletPayLoad(this.origins, this. googleCloudAccount, this.pass);

  final List<String> origins;
  final String googleCloudAccount;
  final Map<String, dynamic> pass;
  
  Map<String, dynamic> toJson() => {
    'aud': 'google',
    'origins': origins,
    'iss': googleCloudAccount,
    'iat': DateTime.now().millisecondsSinceEpoch,
    'typ': 'savetowallet',
    'payload': {
      'genericObjects': [pass],
    },
  };
}

class _GenericPass {

  _GenericPass(this.issuer, this.mainImageUri, 
  this.language, this.header, this.body,);

  final String issuer;
  final String mainImageUri;
  final String language;
  final String header;
  final String body;
  final String uuid = const Uuid().v4();

    Map<String, dynamic> toJson() => {
      'id': '$issuer.$uuid',
      'classId': '$issuer.global_gamer_pass',
      'genericType': 'GENERIC_TYPE_UNSPECIFIED',
      'hexBackgroundColor': '#4285f4',
      'logo': {
        'sourceUri': {
          'uri': 'https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg',
        },
      },
      'cardTitle': {
        'defaultValue': {
          'language': language,
          'value': header,
        },
      },
      'subheader': {
        'defaultValue': {
          'language': language,
          'value': 'Message',
        },
      },
      'header': {
        'defaultValue': {
          'language': language,
          'value': body,
        },
      },
      'heroImage': {
        'sourceUri': {
          'uri': mainImageUri,
        },
      },
      'textModulesData': [
        {
          'header': 'Description',
          'body': body,
          'id': 'body',
        }
      ]
    };
}

String generateJsonPass(String issuer, String mainImageUri, String language, 
  String header, String body,) {
  final pass = _GenericPass(issuer, mainImageUri, language, header, body,);
  final payload = _WalletPayLoad(['localhost'], 
  'global-citizen-pass@global-citizen-game.iam.gserviceaccount.com', pass.toJson(),);
  return jsonEncode(payload);
}
