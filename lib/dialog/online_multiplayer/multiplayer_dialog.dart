import 'package:flutter/material.dart';
import 'package:play_real/widgets/cross_widget.dart';

import '../../config/theme/themedata.dart';
import '../../screens/home.dart';
import 'online_game_setup.dart';

class MultiplayerDialog extends StatefulWidget {
  const MultiplayerDialog({Key? key}) : super(key: key);

  @override
  State<MultiplayerDialog> createState() => _MultiplayerDialogState();
}

class _MultiplayerDialogState extends State<MultiplayerDialog> {
  bool showTextField = false;
  String gameCode = '';
  final _formKey = GlobalKey<FormState>();

  void openTextField() {
    setState(() {
      showTextField = true;
    });
  }

  void closeTextField() {
    setState(() {
      showTextField = false;
      gameCode = '';
      _formKey.currentState?.reset();
    });
  }

  void onGameCodeEntered(String code) {
    // Handle the entered game code here
    print('Game code entered: $code');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      backgroundColor: StartingScreenState.lightmodedarkmode
          ? lightStartGameDialogColor
          : startGameDialogColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Options',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: "GameFont",
                    fontWeight: FontWeight.w500,
                    color: textColor,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => openTextField(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: StartingScreenState.lightmodedarkmode
                        ? lightCommonButton1
                        : CommonButton,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Enter Game Code',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "GameFont",
                      fontWeight: FontWeight.w500,
                      color: StartingScreenState.lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : buttonForegroundColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: showTextField
                      ? null
                      : () {
                          // show start game Dialog
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => onlineGameDialog());
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: StartingScreenState.lightmodedarkmode
                        ? lightCommonButton1
                        : CommonButton,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Start New Game',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "GameFont",
                      fontWeight: FontWeight.w500,
                      color: StartingScreenState.lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : buttonForegroundColor,
                    ),
                  ),
                ),
                if (showTextField)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white), // Text color
                        cursorColor: Colors.white, // Cursor color
                        decoration: InputDecoration(
                          labelText: 'Enter Game Code',
                          labelStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ), // Label text color
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2), // Border color when focused
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                                width: 1), // Border color when not focused
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[800], // Background color
                          suffixIcon: IconButton(
                            onPressed: () => onGameCodeEntered(gameCode),
                            icon: Icon(
                              Icons.play_circle,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            gameCode = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a game code';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => closeTextField(),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "GameFont",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            crossWidget(context, 0.0, 0.0),
          ],
        ),
      ),
    );
  }
}
