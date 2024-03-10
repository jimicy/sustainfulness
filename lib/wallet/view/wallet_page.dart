import 'package:flutter/material.dart';
import 'package:global_citizen_game/wallet/google_wallet/wallet_app.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Sharing center'))),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(fit:BoxFit.cover, image: NetworkImage('https://i.imgur.com/9dMfarG.jpg'))), 
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Center(child: 
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: 
                      Text('Praise the sun!', style: TextStyle(color: const Color.fromARGB(255, 44, 49, 51), fontSize: 30, fontWeight: FontWeight.bold),)),)])]),
          ),
      bottomNavigationBar: BottomAppBar(color: Colors.transparent, child: 
      Center(
        child: WalletApp(
            cardImgUri: 'https://i.imgur.com/9dMfarG.jpg',
            language: 'en-US',
            title: 'mindfulness Card',
            message: 'place holder desc',
          ),),),
    );
    // return Material(
    //   child: WalletApp(
    //         cardImgUri: 'https://i.imgur.com/9dMfarG.jpg',
    //         language: 'en-US',
    //         title: 'mindfulness Card',
    //         message: 'place holder desc',
    //       ),
    // );
  }
}
