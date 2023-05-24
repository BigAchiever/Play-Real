import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:play_real/colors/theme/themedata.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Center(
            child: SpinKitFoldingCube(
              color: StartingScreenState.lightmodedarkmode
                  ? Colors.lightBlue.shade500
                  : borderColor,
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}
