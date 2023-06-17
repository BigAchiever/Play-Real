import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:play_real/background.dart';
import 'package:play_real/screens/home.dart';

import '../config/theme/themedata.dart';

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(
          context, '/home'); // Navigate to the main screen after a delay
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  StartingScreenState.lightmodedarkmode
                      ? lightGradientColor1
                      : gradientColor1,
                  StartingScreenState.lightmodedarkmode
                      ? lightGradientColor2
                      : gradientColor2,
                ],
              ),
            ),
          ),
          AnimatedBubbles(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(delay: 1000.ms, duration: 1800.ms) // shimmer +
                    .shake(hz: 4, curve: Curves.easeInOutCubic),
                SizedBox(height: 40),
                Text(
                  'Experience the thrill of\nplaying real',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: "GameFont"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
