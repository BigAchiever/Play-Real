import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';

import '../services/copy.dart';

class GeneratedTeamCodeButton extends StatelessWidget {
  final String teamCode;

  const GeneratedTeamCodeButton({Key? key, required this.teamCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () => copyToClipboard(context, teamCode),
        style: ElevatedButton.styleFrom(
          backgroundColor: StartingScreenState.lightmodedarkmode
              ? lightCommonButton2
              : CommonButton2,
          shape: const StadiumBorder(),
        ),
        child: Row(
          children: [
            Text(
              teamCode,
              style: TextStyle(
                fontSize: 18,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: StartingScreenState.lightmodedarkmode
                    ? lightbuttonForegroundColor
                    : textColor,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.copy_all,
              color: StartingScreenState.lightmodedarkmode
                  ? lightbuttonForegroundColor
                  : textColor,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
