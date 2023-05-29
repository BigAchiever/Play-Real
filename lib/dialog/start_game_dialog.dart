import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/dialog/widgets/difficulty_widget.dart';
import 'package:play_real/dialog/widgets/gird_widget.dart';
import 'package:play_real/screens/home.dart';
import 'package:play_real/dialog/widgets/player_widget.dart';
import 'package:play_real/widgets/cross_widget.dart';

import '../widgets/audio_player.dart';
import 'widgets/difficult_button.dart';
import '../screens/game_screen.dart';

class GameDialog extends StatefulWidget {
  const GameDialog({Key? key}) : super(key: key);

  @override
  _GameDialogState createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {
  int numberOfPlayers = 2;
  int count = 1;
  int selectedGridSize = 7;
  DifficultyLevel selectedDifficulty = DifficultyLevel.Default;
  final AudioPlayerHelper audioPlayerHelper = AudioPlayerHelper();

  void playAudio() {
    audioPlayerHelper.playAudio();
  }

  void onPlayerCountChanged(int count) {
    setState(() {
      numberOfPlayers = count;
    });
  }

  void onDifficultyChanged(DifficultyLevel difficulty) {
    setState(() {
      selectedDifficulty = difficulty;
    });
  }

  void selectGridSize(int gridSize) {
    setState(() {
      selectedGridSize = gridSize;
    });
  }

  Future<void> _startGame() async {
    // play audio
    if (StartingScreenState.musicbutton == true) {
      playAudio();
    }
    debugPrint(
        'Starting game with $numberOfPlayers players, $selectedDifficulty difficulty, $selectedGridSize grid size');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          numberOfPlayers: numberOfPlayers,
          count: count,
          difficulty: selectedDifficulty,
          gridSize: selectedGridSize,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'New Game',
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: "GameFont",
                      fontWeight: FontWeight.w500,
                      color: textColor,
                      letterSpacing: 1.2),
                ),
              ),
              const SizedBox(height: 28),
              PlayerCountSelectionWidget(
                // from PlayerCountSelectionWidget
                onPlayerCountChanged: onPlayerCountChanged,
              ),
              const SizedBox(height: 16),
              DifficultySelectionWidget(
                // from DifficultySelectionWidget
                onDifficultyChanged: onDifficultyChanged,
              ),
              const SizedBox(height: 16),
              GridSizeSelectionWidget(
                // from GridSizeSelectionWidget
                onGridSizeChanged: selectGridSize,
              ),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: size.width / 2,
                  height: size.height / 15,
                  child: ElevatedButton(
                    onPressed: _startGame,
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
                      'Lets Go!',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "GameFont",
                          fontWeight: FontWeight.w500,
                          color: StartingScreenState.lightmodedarkmode
                              ? lightbuttonForegroundColor
                              : buttonForegroundColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16)
            ],
          ),
          crossWidget(context, 0.0, 0.0)
        ]),
      ),
    );
  }
}
