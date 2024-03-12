import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_citizen_game/app/revealed_card/cubit/daily_element_cubit.dart';
import 'package:global_citizen_game/navbar/view/nav_bar.dart';

class RevealCardPage extends StatelessWidget {
  const RevealCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Set a new random daily element.
    context.read<DailyElementCubit>().setNewDailyElement();

    return Scaffold(
      backgroundColor: Color.fromRGBO(78, 109, 127, 1),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/reveal_bg.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          RevealedElementAnimation(
            elementAssetPath:
                context.read<DailyElementCubit>().elementAssetPath,
          ),
          NetCaptureAnimation(),
          SeeCardButton(),
        ],
      ),
    );
  }
}

class NetCaptureAnimation extends StatelessWidget {
  const NetCaptureAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return NetCapture()
        .animate()
        .fadeIn(
          curve: Curves.easeOut,
          duration: const Duration(
            milliseconds: 1500,
          ),
        )
        .slide(
          begin: const Offset(-1, 0),
          duration: const Duration(
            milliseconds: 1000,
          ),
          curve: Curves.easeOut,
        );
  }
}

class NetCapture extends StatelessWidget {
  const NetCapture({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Transform.translate(
        offset: const Offset(-30, 10),
        child: SizedBox(
          child: Image(
            image: AssetImage(
              'assets/images/reveal_net.png',
            ),
          ),
        ),
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
      alignment: Alignment.center,
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

class SeeCardButton extends StatelessWidget {
  const SeeCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Transform.translate(
        offset: const Offset(0, 200),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const BottomNavBar();
                },
              ),
            );
          },
          child: const Text('See Card'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(231, 212, 165, 1.0),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
          ),
        ),
      ),
    );
  }
}
