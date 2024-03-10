import 'package:flutter/material.dart';
import 'package:global_citizen_game/wallet/google_wallet/wallet_app.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({
    required this.cardImgUri,
    required this.title,
    required this.message,
    super.key
  });

  final String cardImgUri;
  final String message;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Sharing center'))),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(fit:BoxFit.cover, image: NetworkImage(cardImgUri))), 
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Center(child: 
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: 
                      Text(message, style: TextStyle(color: const Color.fromARGB(255, 44, 49, 51), fontSize: 30, fontWeight: FontWeight.bold),)),)])]),
          ),
      bottomNavigationBar: BottomAppBar(color: Colors.transparent, child: 
      Center(
        child: WalletApp(
            cardImgUri: cardImgUri,
            title: title,
            message: message,
          ),),),
    );
  }
}
