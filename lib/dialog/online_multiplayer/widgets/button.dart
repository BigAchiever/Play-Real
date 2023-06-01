import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';

class TeamcodeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TeamcodeButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: StartingScreenState.lightmodedarkmode
              ? lightCommonButton2
              : CommonButton2,
          shape: const StadiumBorder(),
        ),
        child: Text(
          "Teamcode",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "GameFont",
            fontWeight: FontWeight.w500,
            color: StartingScreenState.lightmodedarkmode
                ? lightbuttonForegroundColor
                : textColor,
          ),
        ),
      ),
    );
  }
}
