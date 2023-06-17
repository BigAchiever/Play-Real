import 'package:flutter/material.dart';
import 'package:play_real/online_multiplayer/screens/game.dart';

import 'package:play_real/widgets/cross_widget.dart';
import 'package:play_real/widgets/error_widget.dart';

import '../config/theme/themedata.dart';

import '../network/game_server.dart';
import '../screens/home.dart';
import '../widgets/loader.dart';
import 'online_game_setup.dart';

class MultiplayerDialog extends StatefulWidget {
  const MultiplayerDialog({Key? key}) : super(key: key);

  @override
  State<MultiplayerDialog> createState() => _MultiplayerDialogState();
}

class _MultiplayerDialogState extends State<MultiplayerDialog> {
  bool showTextField = false;
  final _formKey = GlobalKey<FormState>();
  String uid = "not joined";
  String title = "Choose an option";
  bool showNewGameButton = true;

  final TextEditingController _gameCodeController = TextEditingController();

  void openTextField() {
    setState(() {
      showTextField = true;
    });
  }

  void closeTextField() {
    setState(() {
      showTextField = false;
      showNewGameButton = true; //"New Game" button
      _gameCodeController.clear();
      _formKey.currentState?.reset();
    });
  }

  Future<void> onGameCodeEntered(String code) async {
    String playerId2 = "joined";

    final gameSessionId = await getGameSessionIdFromTeamCode(code);

    if (gameSessionId != null) {
      final movesId = await getMovesDocumentId(gameSessionId);

      if (movesId != true) {
        // Join the game session
        await joinGameSession(
          gameSessionId,
          playerId2,
          1,
          1,
          movesId,
        );

        // Close the dialog
        Navigator.pop(context);

        // Show the online game screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OnlineGameScreen(
              gameSessionId: gameSessionId,
              movesId: movesId,
            ),
          ),
        );
      }
    } else {
      showError(context, "Invalid team code");
      print('Invalid, No game session found');
    }
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
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "GameFont",
                    fontWeight: FontWeight.w500,
                    color: StartingScreenState.lightmodedarkmode
                        ? lightbuttonForegroundColor
                        : buttonForegroundColor,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        openTextField();
                        showNewGameButton = false;
                      },
                      style: ElevatedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        backgroundColor: StartingScreenState.lightmodedarkmode
                            ? lightCommonButton1
                            : CommonButton,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                      ),
                      child: Text(
                        'Enter teamcode',
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
                    SizedBox(width: 10),
                    if (showNewGameButton)
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
                                  builder: (context) {
                                    return FutureBuilder(
                                      future: Future.delayed(
                                          const Duration(milliseconds: 200)),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return const onlineGameDialog();
                                        } else {
                                          return const LoadingScreen(
                                            text: 'Loading...',
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                        style: ElevatedButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            backgroundColor:
                                StartingScreenState.lightmodedarkmode
                                    ? lightCommonButton1
                                    : CommonButton,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            )),
                        child: Text(
                          'New game',
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
                  ],
                ),
                SizedBox(height: 10),
                if (showTextField)
                  showTextField
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              width: MediaQuery.of(context).size.width * 0.6,
                              curve: Curves.easeInOut,
                              child: TextFormField(
                                controller: _gameCodeController,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  labelText: 'Enter 6 digit code',
                                  labelStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: messageBoxColor,
                                  suffixIcon: IconButton(
                                    splashRadius: 25,
                                    splashColor: successColor,
                                    onPressed: () => onGameCodeEntered(
                                        _gameCodeController.text),
                                    icon: Icon(
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black,
                                          offset: Offset(2.0, 1.0),
                                        ),
                                      ],
                                      Icons.play_circle,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ElevatedButton(
                                    onPressed: closeTextField,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "GameFont",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
              ],
            ),
            crossWidget(context, 0.0, 0.0),
          ],
        ),
      ),
    );
  }
}
