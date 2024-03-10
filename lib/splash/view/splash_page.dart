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
            BlurRiver(),
            River(),
            Bamboo(),
            Bamboo2(),
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
                delay: const Duration(
                  milliseconds: 200,
                ),
              )
              .slide(
                begin: const Offset(1, 0),
                duration: const Duration(
                  milliseconds: 400,
                ),
                curve: Curves.easeOut,
                delay: const Duration(
                  milliseconds: 100,
                ),
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
                delay: const Duration(
                  milliseconds: 200,
                ),
              )
              .slide(
                begin: const Offset(1, 0),
                duration: const Duration(
                  milliseconds: 400,
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
            delay: const Duration(
              milliseconds: 300,
            ),
          )
          .slide(
            begin: const Offset(-1, 0),
            duration: const Duration(
              milliseconds: 400,
            ),
            curve: Curves.easeOut,
            delay: const Duration(
              milliseconds: 400,
            ),
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
            delay: const Duration(
              milliseconds: 300,
            ),
          )
          .slide(
            begin: const Offset(-0.5, 0),
            duration: const Duration(
              milliseconds: 400,
            ),
            curve: Curves.easeOut,
            delay: const Duration(
              milliseconds: 700,
            ),
          ),
    );
  }
}

class BlurRiver extends StatelessWidget {
  const BlurRiver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: null,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Transform.translate(
          offset: Offset.zero,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaY: 5,
              sigmaX: 5,
            ), //SigmaX and Y are just for X and Y directions
            child: Image.asset('assets/images/splash2_river.png'),
          ).animate().fadeOut(
                curve: Curves.easeOut,
                duration: const Duration(
                  milliseconds: 3000,
                ),
              ),
        ),
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
      child: Align(
        alignment: Alignment.bottomRight,
        child: Transform.translate(
          offset: Offset.zero,
          child: const Image(
            image: AssetImage(
              'assets/images/splash2_river.png',
            ),
          ).animate().fadeIn(
                curve: Curves.easeOut,
                duration: const Duration(
                  milliseconds: 4000,
                ),
              ),
        ),
      ),
    );
  }
}
