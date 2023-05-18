import 'package:flutter/material.dart';
import 'package:play_real/players_count.dart';

import 'difficulty_level.dart';

class GameDialog extends StatefulWidget {
  const GameDialog({Key? key}) : super(key: key);

  @override
  _GameDialogState createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {
  int _numberOfPlayers = 2;
  DifficultyLevel _selectedDifficulty = DifficultyLevel.normal;

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

  void _startGame() {
    // Handle starting the game with selected options
    // Here, you can navigate to the game screen or perform any other desired action
    print(
        'Start game with $_numberOfPlayers players, $_selectedDifficulty difficulty');
    Navigator.pop(context); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      backgroundColor: Colors.black87,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'New Game',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Number of Players:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
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
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
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
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _startGame,
                child: const Text(
                  'Start Game',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
