import 'package:flutter/material.dart';
import 'package:play_real/players_count.dart';

import 'difficulty_level.dart';
import 'game_screen.dart';
import 'grid_button.dart';

class GameDialog extends StatefulWidget {
  const GameDialog({Key? key}) : super(key: key);

  @override
  _GameDialogState createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {
  int _numberOfPlayers = 2;
  int count = 1;
  DifficultyLevel _selectedDifficulty = DifficultyLevel.Default;

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

  void _selectGridSize(int gridSize) {
    setState(() {
      _selectedGridSize = gridSize;
    });
  }

  void _startGame() {
    // Handle starting the game with selected options
    // Here, you can navigate to the game screen or perform any other desired action
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      backgroundColor: Colors.black87,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.orange,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'New Game',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "GameFont",
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Number of Players:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
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
            const Text(
              'Difficulty Level:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: Colors.white,
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
            const Text(
              'Gird Size:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "GameFont",
                fontWeight: FontWeight.w500,
                color: Colors.white,
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
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: size.width / 2,
                height: size.height / 15,
                child: ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Lets Go!',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "GameFont",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
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
