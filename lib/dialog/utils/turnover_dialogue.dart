import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';

class DialogUtils {
  static void showTurnOverDialog(
      BuildContext context, Function setStateCallback) {
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
          width: 180,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Turn Over!',
                style: TextStyle(
                  fontSize: 24,
                  color: StartingScreenState.lightmodedarkmode
                      ? lightbuttonForegroundColor
                      : textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Your turn is over!\nComplete your task for the game to continue.',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: StartingScreenState.lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : textColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: StartingScreenState.lightmodedarkmode
                      ? lightbuttonForegroundColor
                      : textColor,
                  backgroundColor: StartingScreenState.lightmodedarkmode
                      ? lightCommonButton1
                      : CommonButton2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Fine, I wasn't cheating anyway 🙂"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
