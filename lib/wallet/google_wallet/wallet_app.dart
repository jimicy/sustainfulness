import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';
import 'package:flutter_google_wallet/widget/add_to_google_wallet_button.dart';
import 'package:uuid/uuid.dart';

class WalletApp extends StatefulWidget {
  
  WalletApp({super.key});
  
  final flutterGoogleWalletPlugin = FlutterGoogleWalletPlugin();

  @override
  State<WalletApp> createState() => _WalletAppState();
}

class _WalletAppState extends State<WalletApp> {
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
    return MaterialApp(
      localizationsDelegates: const [I18nGoogleWallet.delegate],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder<bool>(
                future: _isWalletAvailable,
                builder: (BuildContext context, AsyncSnapshot<bool> available) {
                  if (available.data == true) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: AddToGoogleWalletButton(
                          locale: const Locale('en', 'EN'),
                          onPress: () {
                            widget.flutterGoogleWalletPlugin.savePasses(
                                jsonPass: generateJsonPass(
                                  '3388000000022316652', 
                                  'https://i.imgur.com/9dMfarG.jpg', 
                                  'en-US', 
                                  'header', 
                                  'place holder desc'),
                                addToGoogleWalletRequestCode: 0,);
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//https://developers.google.com/wallet/reference/rest/v1/Jwt
class _WalletPayLoad {

  _WalletPayLoad(this.origins, this. googleCloudAccount, this.passes);

  final List<String> origins;
  final String googleCloudAccount;
  final List<Object> passes;
  
  Map<String, dynamic> toJson() => {
    'aud': 'google',
    'origins': origins,
    'iss': googleCloudAccount,
    'iat': DateTime.now().millisecondsSinceEpoch,
    'typ': 'savetowallet',
    'payload': {
      'loyaltyObjects': passes,
    },
  };
}

class _Pass {

  _Pass(this.issuer, this.mainImageUri, 
  this.language, this.header, this.body,);

  final String issuer;
  final String mainImageUri;
  final String language;
  final String header;
  final String body;
  final String uuid = const Uuid().v4();

    Map<String, dynamic> toJson() => {
      'id': '$issuer.$uuid',
      'classId': '$issuer.test',
      'localizedProgramName': {
      'defaultValue': {
          'language': language,
          'value': header,
        },
      },
      'loyaltyPoints': {
        'balance': {
          'string': body,
        },
        'localizedLabel': {
          'defaultValue': {
            'language': language,
            'value': 'Message',
          },
        },
      },
      'textModulesData': [
        {
          'id': 'content',
          'header': 'Desc',
          'body': body,
        },
      ],
      'imageModulesData': [
        {
          'mainImage': {
            'sourceUri': {
              'uri': mainImageUri,
            },
          },
          'id': 'card-art',
        },
      ],
      'heroImage': {
        'sourceUri': {
          'uri': mainImageUri,
        },
      },
      'hexBackgroundColor': '#4285f4',
      'state': 'active',
    };
}

String generateJsonPass(String issuer, String mainImageUri, String language, 
  String header, String body,) {
  final pass = _Pass(issuer, mainImageUri, language, header, body,);
  final payload = _WalletPayLoad(['localhost'], 
  'global-citizen-pass@global-citizen-game.iam.gserviceaccount.com', [pass],);

  return jsonEncode(payload);
}
