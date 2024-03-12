import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';
import 'package:global_citizen_game/app/revealed_card/cubit/daily_element_cubit.dart';
import 'package:global_citizen_game/app/revealed_card/view/revealed_card_page.dart';
import 'package:global_citizen_game/counter/counter.dart';
import 'package:global_citizen_game/game/view/game_page.dart';
import 'package:global_citizen_game/l10n/l10n.dart';
import 'package:global_citizen_game/navbar/view/nav_bar.dart';
import 'package:global_citizen_game/share/view/share_page.dart';
import 'package:global_citizen_game/splash/view/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<DailyElementCubit>(
            create: (BuildContext context) => DailyElementCubit(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Outfit',
            appBarTheme:
                const AppBarTheme(color: Color.fromRGBO(46, 60, 68, 1)),
            colorScheme: ColorScheme.fromSwatch(
              accentColor: Color.fromRGBO(54, 70, 79, 1),
            ),
          ),
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            I18nGoogleWallet.delegate
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: SplashPage(),
          // home: const BottomNavBar(),
          // home: const CounterPage(),
          // home: RevealCardPage(),
          // home: const SharePage(
          //   cardImgUri:
          //       'https://storage.googleapis.com/global-citizen-assets/card_water1.png',
          //   title: 'Mindfulness Card',
          //   message: 'Praise the sun!',
          // )
        ));
  }
}
