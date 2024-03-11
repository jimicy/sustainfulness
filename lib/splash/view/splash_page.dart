import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashPage2Animation();
  }
}

const int SPLASH_PAGE2_BASE_DURATION = 300;

class SplashPage2Animation extends StatelessWidget {
  const SplashPage2Animation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash2_bg.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const Stack(
          children: <Widget>[
            Moon(),
            Cloud(),
            BlurRiverAnimation(),
            RiverAnimation(),
            Bamboo(),
            Bamboo2(),
            FirstTextAnimation(),
            SecondTextAnimation(),
          ],
        ),
      ),
    );
  }
}

class Moon extends StatelessWidget {
  const Moon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: Align(
        alignment: Alignment.centerRight,
        child: Transform.translate(
          offset: const Offset(0, 0),
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
    ).animate().fadeOut(
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

class FirstTextAnimation extends StatelessWidget {
  const FirstTextAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FirstText()
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
          builder: (_, __) => FirstText()
              .animate()
              .fadeIn(curve: Curves.easeOut, duration: 400.ms),
        );
  }
}

class FirstText extends StatelessWidget {
  const FirstText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 304.0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: const Offset(15, -150.0),
          child: const Text(
            'The silent murmur of a flowing stream',
            style: TextStyle(
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SecondText()
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
          builder: (_, __) => SecondText()
              .animate()
              .fadeIn(curve: Curves.easeOut, duration: 400.ms),
        );
  }
}

class SecondText extends StatelessWidget {
  const SecondText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: const Offset(150, -60),
          child: const Text(
            'Captures the essence of a mindful dream',
            style: TextStyle(
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
