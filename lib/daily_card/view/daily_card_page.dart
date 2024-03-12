import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:global_citizen_game/app/revealed_card/cubit/daily_element_cubit.dart';
import 'package:global_citizen_game/share/google_wallet/wallet_app.dart';
import 'package:global_citizen_game/share/social_media/social_media_app.dart';

class DailyCardPage extends StatelessWidget {
  const DailyCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 40,
                child: Transform.translate(
                  offset: Offset(20, 0),
                  child: WalletApp(
                  cardImgUri: context.read<DailyElementCubit>().state.cardUri,
                  title: 'Daily sustainfulness card',
                  message: 'Join me in this challenge!',
                  ),
                ),
              ),
              SocialMediaShareApp(
                cardImgUri: context.read<DailyElementCubit>().state.cardUri,
                message:
                    'This is my daily sustainfulness card. Join me in this challenge!',
              ),
              SizedBox(width: 20)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          AnimationCard(
            child: Image(
              filterQuality: FilterQuality.high,
              height: 450,
              image:
                  NetworkImage(context.read<DailyElementCubit>().state.cardUri),
            ),
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

class AnimationCard extends StatefulWidget {
  const AnimationCard({super.key, required this.child});

  final Widget child;

  @override
  State<AnimationCard> createState() => _AnimationCardState();
}

class _AnimationCardState extends State<AnimationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController scaleAnimationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    scaleAnimation = Tween(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: scaleAnimationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => scaleAnimationController.forward(),
      onPointerUp: (_) => scaleAnimationController.reverse(),
      onPointerCancel: (_) => scaleAnimationController.reverse(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => scaleAnimationController.forward(),
        onExit: (_) => scaleAnimationController.reverse(),
        child: ScaleTransition(
          scale: scaleAnimation,
          alignment: Alignment.center,
          filterQuality: FilterQuality.high,
          child: GestureDetector(
            onTap: () => _showDialog(context),
            // Tilt here
            child: Tilt(
              borderRadius: BorderRadius.circular(20),
              tiltConfig: const TiltConfig(filterQuality: FilterQuality.high),
              lightConfig: const LightConfig(
                minIntensity: 0.1,
                maxIntensity: 0.4,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            child: Transform.scale(
              scale: 1.2,
              filterQuality: FilterQuality.high,
              // Tilt here
              child: Tilt(
                borderRadius: BorderRadius.circular(20),
                tiltConfig: const TiltConfig(
                  enableRevert: false,
                  enableSensorRevert: false,
                  filterQuality: FilterQuality.high,
                ),
                lightConfig: const LightConfig(
                  minIntensity: 0.1,
                  maxIntensity: 0.4,
                ),
                shadowConfig: const ShadowConfig(disable: true),
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}
