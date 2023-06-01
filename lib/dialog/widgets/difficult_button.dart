import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';

import '../../screens/home.dart';

enum DifficultyLevel {
  // ignore: constant_identifier_names
  Default,
  kids,
  medium,
  sarcastic,
  easy,
}


class DifficultyButton extends StatelessWidget {
  final DifficultyLevel level;
  final bool isSelected;
  final ValueChanged<DifficultyLevel> onChanged;

  const DifficultyButton({
    Key? key,
    required this.level,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 40,
      child: ElevatedButton(
        onPressed: () => onChanged(level),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? StartingScreenState.lightmodedarkmode
                  ? lightSelectedColor
                  : selectedColor
              : StartingScreenState.lightmodedarkmode
                  ? lightUnselectedButtonColor
                  : unselectedButtonColor,
          shape: StadiumBorder(),
          padding: const EdgeInsets.all(2),
        ),
        child: Text(
          level.toString().split('.').last,
          style: TextStyle(
            fontSize: 14,
            fontFamily: "GameFont",
            fontWeight: FontWeight.w500,
            color: StartingScreenState.lightmodedarkmode
                ? lightbuttonForegroundColor
                : textColor,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
