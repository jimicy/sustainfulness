import 'package:flutter/material.dart';
import 'package:global_citizen_game/navbar/view/nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GameWebView extends StatefulWidget {
  const GameWebView({super.key});

  @override
  State<GameWebView> createState() => _GameWebViewState();
}

class _GameWebViewState extends State<GameWebView> {
  late final WebViewController controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(Colors.transparent)
      ..loadRequest(
        Uri.parse(
            'https://568f7e56-4141-44a9-bcc4-0c7b7d6a88c4-00-ab9ubil012q4.spock.replit.dev/'),
      )
      ..setNavigationDelegate(NavigationDelegate(
          onPageFinished: (_) => setState(() {
                _loading = false;
              })))
      ..addJavaScriptChannel("messageHandler",
          onMessageReceived: (JavaScriptMessage javaScriptMessage) {
        if (javaScriptMessage.message == "game-finished") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const BottomNavBar();
              },
            ),
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(78, 109, 127, 1),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/splash2_bg.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          WebViewWidget(controller: controller),
          if (_loading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Loading Game...',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      )),
                  SizedBox(height: 10),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
