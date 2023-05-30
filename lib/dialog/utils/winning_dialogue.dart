import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';

class GameWonDialog {
  static void showGameWonDialog(
    BuildContext context,
    int number,
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
          width: 140,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                //showing current player's number
                'Conguratulations Player $number has Won the Game!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: StartingScreenState.lightmodedarkmode
                      ? lightbuttonForegroundColor
                      : textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Hope you enjoyed the game!🥳 Do you want to continue the Game?',
                style: TextStyle(
                    fontSize: 16,
                    color: StartingScreenState.lightmodedarkmode
                        ? lightbuttonForegroundColor
                        : textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 34),
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
                          ? lightUnselectedButtonColor
                          : unselectedButtonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Quit!"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: StartingScreenState.lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : textColor,
                      backgroundColor: StartingScreenState.lightmodedarkmode
                          ? selectedColor
                          : lightSelectedColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Play Again!"),
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
