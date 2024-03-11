import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';
import 'package:global_citizen_game/counter/counter.dart';
import 'package:global_citizen_game/l10n/l10n.dart';
import 'package:global_citizen_game/share/view/share_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [...AppLocalizations.localizationsDelegates, I18nGoogleWallet.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
      //const SharePage(cardImgUri: 'https://i.imgur.com/9dMfarG.jpg', title: 'Mindfulness Card', message: 'Praise the sun!',)
    );
  }
}
