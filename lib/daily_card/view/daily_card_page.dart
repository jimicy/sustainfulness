import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:global_citizen_game/app/revealed_card/cubit/daily_element_cubit.dart';
import 'package:global_citizen_game/share/google_wallet/wallet_app.dart';
import 'package:global_citizen_game/share/social_media/social_media_app.dart';

class DailyCardPage extends StatelessWidget {
  const DailyCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('element ${context.read<DailyElementCubit>().state.element}');
    print(
        'elementAssetPath ${context.read<DailyElementCubit>().elementAssetPath}');
    print(
        'elementBgAssetPath ${context.read<DailyElementCubit>().elementBgAssetPath}');

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            context.read<DailyElementCubit>().elementBgAssetPath,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Transform.translate(
                  offset: const Offset(20, 0),
                  child: SocialMediaShareApp(
                    cardImgUri: context.read<DailyElementCubit>().state.cardUri,
                    message:
                        'This is my daily sustainfulness card. Join me in this challenge!',
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: WalletApp(
                  cardImgUri: context.read<DailyElementCubit>().state.cardUri,
                  title: 'Daily sustainfulness card',
                  message: 'Join me in this challenge!',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Image(
            height: 530,
            image:
                NetworkImage(context.read<DailyElementCubit>().state.cardUri),
          ),
          RevealedElementAnimation(
            elementAssetPath:
                context.read<DailyElementCubit>().elementAssetPath,
          ),
        ],
      ),
    );
  }
}

class RevealedElementAnimation extends StatelessWidget {
  const RevealedElementAnimation({required this.elementAssetPath, super.key});

  final String elementAssetPath;

  @override
  Widget build(BuildContext context) {
    return RevealedElement(
      elementAssetPath: elementAssetPath,
    )
        .animate()
        .fadeIn(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: 1500,
          ),
        )
        .slide(
          begin: const Offset(0, 0.1),
          duration: const Duration(
            milliseconds: 1000,
          ),
          curve: Curves.easeOut,
        )
        .then()
        .animate(
      onPlay: (controller) {
        controller.repeat();
      },
    ).shimmer(
      duration: 2400.ms,
    );
  }
}

class RevealedElement extends StatelessWidget {
  const RevealedElement({required this.elementAssetPath, super.key});

  final String elementAssetPath;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        child: Image(
          image: AssetImage(
            elementAssetPath,
          ),
        ),
      ),
    );
  }
}
