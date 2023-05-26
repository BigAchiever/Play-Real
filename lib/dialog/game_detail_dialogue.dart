import 'package:flutter/material.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';
import 'package:play_real/dialog/widgets/players_count.dart';

import '../widgets/audio_player.dart';
import 'widgets/difficulty_level.dart';
import '../screens/game_screen.dart';
import 'widgets/grid_button.dart';

class GameDialog extends StatefulWidget {
  const GameDialog({Key? key}) : super(key: key);

  @override
  _GameDialogState createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {
  int _numberOfPlayers = 2;
  int count = 1;
  DifficultyLevel _selectedDifficulty = DifficultyLevel.Default;
  final AudioPlayerHelper audioPlayerHelper = AudioPlayerHelper();

  void playAudio() {
    audioPlayerHelper.playAudio();
  }

  void _onPlayerCountChanged(int count) {
    setState(() {
      _numberOfPlayers = count;
    });
  }

  void _onDifficultyChanged(DifficultyLevel difficulty) {
    setState(() {
      _selectedDifficulty = difficulty;
    });
  }

  int _selectedGridSize = 7;

  Future _selectGridSize(int gridSize) async {
    setState(() {
      _selectedGridSize = gridSize;
    });
  }

  Future<void> _startGame() async {
    // play audio
    if (StartingScreenState.musicbutton == true) {
      playAudio();
    }
    debugPrint(
        'Starting game with $_numberOfPlayers players and $_selectedDifficulty difficulty level and $_selectedGridSize grid size');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          numberOfPlayers: _numberOfPlayers,
          count: count,
          difficulty: _selectedDifficulty,
          gridSize: _selectedGridSize,
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
        child: Column(
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
            Text(
              'Number of Players:',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "GameFont",
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  letterSpacing: 1.1),
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: 8,
              children: [
                PlayerCountButton(
                  count: 2,
                  isSelected: _numberOfPlayers == 2,
                  onChanged: _onPlayerCountChanged,
                ),
                PlayerCountButton(
                  count: 3,
                  isSelected: _numberOfPlayers == 3,
                  onChanged: _onPlayerCountChanged,
                ),
                PlayerCountButton(
                  count: 4,
                  isSelected: _numberOfPlayers == 4,
                  onChanged: _onPlayerCountChanged,
                ),
                PlayerCountButton(
                  count: 5,
                  isSelected: _numberOfPlayers == 5,
                  onChanged: _onPlayerCountChanged,
                ),
                PlayerCountButton(
                  count: 6,
                  isSelected: _numberOfPlayers == 6,
                  onChanged: _onPlayerCountChanged,
                ),
                PlayerCountButton(
                  count: 7,
                  isSelected: _numberOfPlayers == 7,
                  onChanged: _onPlayerCountChanged,
                ),
                PlayerCountButton(
                  count: 8,
                  isSelected: _numberOfPlayers == 8,
                  onChanged: _onPlayerCountChanged,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Difficulty Level:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: 8,
              children: DifficultyLevel.values.map((level) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: DifficultyButton(
                    level: level,
                    isSelected: _selectedDifficulty == level,
                    onChanged: _onDifficultyChanged,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Gird Size:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GridSizeButton(
                  size: 7,
                  isSelected: _selectedGridSize == 7,
                  onChanged: _selectGridSize,
                ),
                const SizedBox(width: 8),
                GridSizeButton(
                  size: 10,
                  isSelected: _selectedGridSize == 10,
                  onChanged: _selectGridSize,
                ),
              ],
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
      ),
    );
  }
}
