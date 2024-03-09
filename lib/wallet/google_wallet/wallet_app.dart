import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';
import 'package:flutter_google_wallet/widget/add_to_google_wallet_button.dart';

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
                            print('pressed buttom');
                            widget.flutterGoogleWalletPlugin.savePasses(
                                jsonPass: exampleJsonPass,
                                addToGoogleWalletRequestCode: 2,);
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
const exampleJsonPass = '''
{
  "aud": "google",
  "origins": [
    "https://localhost:8080"
  ],
  "iss": "global-citizen-pass@global-citizen-game.iam.gserviceaccount.com",
  "iat": 1389816895,
  "typ": "savetowallet",
  "payload": {
    "loyaltyObjects": [
      {
        "barcode": {
          "alternateText": "12345",
          "type": "qrCode",
          "value": "28343E3"
        },
        "linksModuleData": {
          "uris": [
            {
              "kind": "walletobjects#uri",
              "uri": "https://www.baconrista.com/myaccount?id=1234567890",
              "description": "My Baconrista Account"
            }
          ]
        },
        "infoModuleData": {
          "labelValueRows": [
            {
              "columns": [
                {
                  "value": "Jane Doe",
                  "label": "Member Name"
                },
                {
                  "value": "1234567890",
                  "label": "Membership #"
                }
              ]
            },
            {
              "columns": [
                {
                  "value": "2 coffees",
                  "label": "Next Reward in"
                },
                {
                  "value": "01/15/2013",
                  "label": "Member Since"
                }
              ]
            }
          ],
          "showLastUpdateTime": "true"
        },
        "id": "3388000000022316652.test1",
        "loyaltyPoints": {
          "balance": {
            "string": "500"
          },
          "label": "Points"
        },
        "accountId": "1234567890",
        "classId": "3388000000022316652.test",
        "accountName": "Jane Doe",
        "state": "active",
        "version": 1,
        "textModulesData": [
          {
            "body": "You are 5 coffees away from receiving a free bacon fat latte. ",
            "header": "Jane's Baconrista Rewards"
          }
        ]
      }
    ]
  }
}
''';
