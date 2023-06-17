import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';

class LoadingScreen extends StatelessWidget {
  final String text;
  const LoadingScreen({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width / 1.5,
                child: Text(
                  text,
                  style: TextStyle(
                      color: StartingScreenState.lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : textColor,
                      fontSize: 24,
                      fontFamily: "GameFont",
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),
              Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(delay: 1000.ms, duration: 1800.ms) // shimmer +
                  .shake(hz: 4, curve: Curves.easeInOutCubic),
            ],
          ),
        ],
      ),
    );
  }
}
