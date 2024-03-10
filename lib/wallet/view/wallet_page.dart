import 'package:flutter/material.dart';
import 'package:global_citizen_game/wallet/google_wallet/wallet_app.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: WalletApp(
            cardImgUri: 'https://i.imgur.com/9dMfarG.jpg',
            language: 'en-US',
            title: 'mindfulness Card',
            message: 'place holder desc',
          ),
    );
  }
}
