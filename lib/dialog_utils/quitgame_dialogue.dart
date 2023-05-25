import 'package:flutter/material.dart';
import 'package:play_real/colors/theme/themedata.dart';

import '../screens/home.dart';

class QuitDialog {
  static void showGameOverDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: StartingScreenState.lightmodedarkmode
            ? lightStartGameDialogColor
            : DialogBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: StartingScreenState.lightmodedarkmode
                ? lightBorderColor
                : borderColor,
            width: 2,
          ),
        ),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 22,
                  color: StartingScreenState.lightmodedarkmode
                      ? lightbuttonForegroundColor
                      : textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Are you sure you want to quit the game?',
                  style: TextStyle(
                      fontSize: 18,
                      color: StartingScreenState.lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : textColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: StartingScreenState.lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : textColor,
                      backgroundColor: StartingScreenState.lightmodedarkmode
                          ? lightCommonButton1
                          : CommonButton2,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Yes"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: StartingScreenState.lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : textColor,
                      backgroundColor: StartingScreenState.lightmodedarkmode
                          ? lightUnselectedButtonColor
                          : unselectedButtonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("No"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
