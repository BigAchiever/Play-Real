import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';

import 'package:play_real/widgets/cross_widget.dart';

import '../../config/theme/themedata.dart';
import '../../network/game_server.dart';
import '../../screens/home.dart';
import 'online_game_setup.dart';

class MultiplayerDialog extends StatefulWidget {
  const MultiplayerDialog({Key? key}) : super(key: key);

  @override
  State<MultiplayerDialog> createState() => _MultiplayerDialogState();
}

class _MultiplayerDialogState extends State<MultiplayerDialog> {
  bool showTextField = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _gameCodeController = TextEditingController();

  void openTextField() {
    setState(() {
      showTextField = true;
    });
  }

  void closeTextField() {
    setState(() {
      showTextField = false;
      _gameCodeController.clear();
      _formKey.currentState?.reset();
    });
  }

  void onGameCodeEntered(String code) async {
    print('Game code entered: $code');

    await joinGameSessionWithCode();
    Navigator.pop(context);
  }

  Future<void> joinGameSessionWithCode() async {
   
    final playerId = nanoid(8); 
    final gameSessionId =
        await createGameSession(playerId); 
    await joinGameSession(gameSessionId, playerId);
  }

  @override
  Widget build(BuildContext context) {
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
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            onGameCodeEntered(_gameCodeController.text);
                          }
                        }
                      : () {
                          // show start game Dialog
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => onlineGameDialog(),
                          );
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
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _gameCodeController,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Enter Game Code',
                            labelStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[800],
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  onGameCodeEntered(_gameCodeController.text),
                              icon: Icon(
                                Icons.play_circle,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a game code';
                            }
                            return null;
                          },
                        ),
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
