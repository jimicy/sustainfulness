import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:global_citizen_game/navbar/view/nav_bar.dart';
import 'package:global_citizen_game/splash/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashCubit, SplashPageState>(
          builder: (context, pageState) {
        switch (pageState) {
          case SplashPageState.first:
            return SplashPage1Animation();
          case SplashPageState.second:
            return SplashPage2Animation();
          case SplashPageState.last:
            return const BottomNavBar().animate().fadeIn(
                  curve: Curves.easeOut,
                  duration: 1000.ms,
                );
        }
      }),
    );
  }
}

class SplashPage1Animation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(119, 152, 170, 1.0),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/splash1_bg.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Splash1FirstTextAnimation(
                text: 'A mindful path with conscious steps'),
            Splash1SecondTextAnimation(
              text: 'Sustainfulness',
              pageState: SplashPageState.second,
            ),
          ],
        ));
  }
}

const int SPLASH_PAGE2_BASE_DURATION = 300;

class SplashPage2Animation extends StatelessWidget {
  const SplashPage2Animation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(119, 152, 170, 1.0),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/splash2_bg.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ).animate().fadeIn(duration: 1500.ms),
          Moon(),
          Cloud(),

          // Splash Page 2, first of background elements
          Stack(children: <Widget>[
            FogAnimation(
              assetPath: 'assets/images/splash2_fog_left.svg',
              translateOffset: Offset(-10, 120),
              slideOffsetX: -0.5,
            ),
            FogAnimation(
              assetPath: 'assets/images/splash2_fog_right.svg',
              translateOffset: Offset(50, 330),
              slideOffsetX: 0.5,
            ),
          ])
              .animate()
              .fadeOut(
                  curve: Curves.easeInOut, duration: 1000.ms, delay: 5000.ms)
              .swap(builder: (_, __) {
            // Splash Page 2, second set of background elements
            return Stack(children: <Widget>[
              BlurRiverAnimation(),
              RiverAnimation(),
            ]);
          }),

          Bamboo(),
          Bamboo2(),

          // Splash Page 2, first set of text
          const Stack(
            children: <Widget>[
              FirstTextAnimation(
                  text: 'Feel the rhythm of the rustling leaves'),
              SecondTextAnimation(
                text: 'In the gentle whisper of the evening breeze',
                pageState: SplashPageState.second,
              ),
            ],
          ).animate().fadeOut(duration: 500.ms, delay: 5000.ms).swap(
              builder: (_, __) {
            // Splash Page 2, second set of background elements
            return const Stack(children: <Widget>[
              FirstTextAnimation(text: 'The silent murmur of a flowing stream'),
              SecondTextAnimation(
                text: 'Captures the essence of a mindful dream',
                pageState: SplashPageState.last,
              )
            ]);
          }),
        ],
      ),
    );
  }
}

// Splash Page 2 Animated elements ----------------------------------

class Moon extends StatelessWidget {
  const Moon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: Align(
        alignment: Alignment.centerRight,
        child: Transform.translate(
          offset: const Offset(0, 50),
          child: const Image(
            image: AssetImage(
              'assets/images/splash2_moon.png',
            ),
          )
              .animate()
              .fadeIn(
                curve: Curves.easeOut,
                duration: const Duration(
                  milliseconds: SPLASH_PAGE2_BASE_DURATION + 1500,
                ),
              )
              .slide(
                begin: const Offset(1, 0),
                duration: const Duration(
                  milliseconds: SPLASH_PAGE2_BASE_DURATION + 1000,
                ),
                curve: Curves.easeOut,
              ),
        ).animate(
          onPlay: (controller) {
            controller.repeat();
          },
        ).shimmer(
          duration: 2400.ms,
        ),
      ),
    );
  }
}

class Cloud extends StatelessWidget {
  const Cloud({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: null,
      child: Align(
        alignment: Alignment.topRight,
        child: Transform.translate(
          offset: const Offset(0, 75.0),
          child: SvgPicture.asset(
            'assets/images/splash2_clouds.svg',
            width: 408,
            fit: BoxFit.fitWidth,
          )
              .animate()
              .fadeIn(
                curve: Curves.easeOut,
                duration: const Duration(
                  milliseconds: SPLASH_PAGE2_BASE_DURATION + 1500,
                ),
              )
              .slide(
                begin: const Offset(1, 0),
                duration: const Duration(
                  milliseconds: SPLASH_PAGE2_BASE_DURATION + 1000,
                ),
                curve: Curves.easeOut,
                delay: const Duration(
                  milliseconds: 300,
                ),
              ),
        ),
      ),
    );
  }
}

class Bamboo extends StatelessWidget {
  const Bamboo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: null,
      child: Transform.translate(
        offset: const Offset(50, 0),
        child: SvgPicture.asset(
          'assets/images/splash2_foreground1.svg',
          height: double.infinity,
          fit: BoxFit.fitHeight,
          alignment: Alignment.bottomLeft,
        ),
      )
          .animate()
          .fadeIn(
            curve: Curves.easeOut,
            duration: const Duration(
              milliseconds: SPLASH_PAGE2_BASE_DURATION + 1500,
            ),
          )
          .slide(
            begin: const Offset(-1, 0),
            duration: const Duration(
              milliseconds: SPLASH_PAGE2_BASE_DURATION + 1000,
            ),
            curve: Curves.easeOut,
          ),
    );
  }
}

class Bamboo2 extends StatelessWidget {
  const Bamboo2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: null,
      child: Transform.translate(
        offset: const Offset(0, 0),
        child: SvgPicture.asset(
          'assets/images/splash2_foreground2.svg',
          height: double.infinity,
          fit: BoxFit.fitHeight,
          alignment: Alignment.bottomLeft,
        ),
      )
          .animate()
          .fadeIn(
            curve: Curves.easeOut,
            duration: const Duration(
              milliseconds: SPLASH_PAGE2_BASE_DURATION + 1500,
            ),
          )
          .slide(
            begin: const Offset(-0.5, 0),
            duration: const Duration(
              milliseconds: SPLASH_PAGE2_BASE_DURATION + 1000,
            ),
            curve: Curves.easeOut,
            delay: const Duration(
              milliseconds: 700,
            ),
          ),
    );
  }
}

class BlurRiverAnimation extends StatelessWidget {
  const BlurRiverAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaY: 5,
        sigmaX: 5,
      ), //SigmaX and Y are just for X and Y directions
      child: River(),
    )
        .animate()
        .fadeIn(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 1500,
          ),
        )
        .then()
        .fadeOut(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 3000,
          ),
        );
  }
}

class RiverAnimation extends StatelessWidget {
  const RiverAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return River().animate().fadeIn(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 4000,
          ),
        );
  }
}

class River extends StatelessWidget {
  const River({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: null,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Transform.translate(
          offset: const Offset(0, 0),
          child: const Image(
            image: AssetImage(
              'assets/images/splash2_river.png',
            ),
          ),
        ),
      ),
    );
  }
}

class FogAnimation extends StatelessWidget {
  const FogAnimation({
    required this.translateOffset,
    required this.slideOffsetX,
    required this.assetPath,
    super.key,
  });

  final Offset translateOffset;
  final double slideOffsetX;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Fog(translateOffset: translateOffset, assetPath: assetPath)
        .animate()
        .slideX(
            begin: slideOffsetX,
            duration: const Duration(
              milliseconds: SPLASH_PAGE2_BASE_DURATION + 2000,
            ),
            curve: Curves.easeOut)
        .fadeIn(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 600,
          ),
        );
  }
}

class Fog extends StatelessWidget {
  const Fog({
    required this.translateOffset,
    required this.assetPath,
    super.key,
  });

  final Offset translateOffset;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: null,
      child: Align(
        alignment: Alignment.center,
        child: Transform.translate(
          offset: translateOffset,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaY: 9,
              sigmaX: 9,
            ),
            child: SvgPicture.asset(
              assetPath,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}

class FirstTextAnimation extends StatelessWidget {
  const FirstTextAnimation({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return FirstText(text: text)
        .animate(delay: 400.ms)
        .blur()
        .fadeIn(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 1500,
          ),
        )
        .slide(
          begin: const Offset(-1, 0),
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 1000,
          ),
          curve: Curves.easeOut,
          delay: const Duration(
            milliseconds: 300,
          ),
        )
        .then()
        .swap(
          duration: 300.ms,
          builder: (_, __) => FirstText(text: text)
              .animate()
              .fadeIn(curve: Curves.easeOut, duration: 400.ms),
        );
  }
}

class FirstText extends StatelessWidget {
  const FirstText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 304.0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: const Offset(15, -150),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w100,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondTextAnimation extends StatelessWidget {
  const SecondTextAnimation({
    required this.text,
    required this.pageState,
    super.key,
  });

  final String text;
  final SplashPageState pageState;

  @override
  Widget build(BuildContext context) {
    return SecondText(text: text)
        .animate(delay: 2000.ms)
        .blur()
        .fadeIn(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 1500,
          ),
        )
        .slide(
          begin: const Offset(1, 0),
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 1000,
          ),
          curve: Curves.easeOut,
          delay: const Duration(
            milliseconds: 300,
          ),
        )
        .then()
        .swap(
            duration: 300.ms,
            builder: (_, __) =>
                SecondText(text: text).animate(onComplete: (controller) {
                  if (pageState == SplashPageState.last) {
                    Future.delayed(1000.ms, () {
                      context.read<SplashCubit>().setPageState(pageState);
                    });
                  } else {
                    context.read<SplashCubit>().setPageState(pageState);
                  }
                }).fadeIn(curve: Curves.easeOut, duration: 400.ms));
  }
}

class SecondText extends StatelessWidget {
  const SecondText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: const Offset(150, -60),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w100,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Splash Page 1 Animated elements ----------------------------------

class Splash1FirstTextAnimation extends StatelessWidget {
  const Splash1FirstTextAnimation({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Splash1FirstText(text: text)
        .animate(delay: 400.ms)
        .blur()
        .fadeIn(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 1000,
          ),
        )
        .slide(
          begin: const Offset(-1, 0),
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 500,
          ),
          curve: Curves.easeOut,
          delay: const Duration(
            milliseconds: 300,
          ),
        )
        .then()
        .swap(
          duration: 300.ms,
          builder: (_, __) => Splash1FirstText(text: text)
              .animate()
              .fadeIn(curve: Curves.easeOut, duration: 400.ms),
        );
  }
}

class Splash1FirstText extends StatelessWidget {
  const Splash1FirstText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Align(
        alignment: Alignment.center,
        child: Transform.translate(
          offset: const Offset(50, 0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w100,
              color: Colors.white,
              shadows: [
                Shadow(color: Colors.grey, blurRadius: 8, offset: Offset(2, 2))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Splash1SecondTextAnimation extends StatelessWidget {
  const Splash1SecondTextAnimation({
    required this.text,
    required this.pageState,
    super.key,
  });

  final String text;
  final SplashPageState pageState;

  @override
  Widget build(BuildContext context) {
    return Splash1SecondText(text: text)
        .animate(delay: 1500.ms)
        .blur()
        .fadeIn(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: SPLASH_PAGE2_BASE_DURATION + 800,
          ),
        )
        .then()
        .swap(
            duration: 300.ms,
            builder: (_, __) =>
                Splash1SecondText(text: text).animate(onComplete: (controller) {
                  Future.delayed(1000.ms, () {
                    context.read<SplashCubit>().setPageState(pageState);
                  });
                }).fadeIn(curve: Curves.easeOut, duration: 500.ms));
  }
}

class Splash1SecondText extends StatelessWidget {
  const Splash1SecondText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: const Offset(50, -60),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
