import 'package:flutter/material.dart';
import 'package:play_real/background.dart';
import 'package:play_real/dice.dart';

import 'message_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int _boardSize = 7;
  final double _boardPadding = 16;
  final List<int> _boardNumbers = List.generate(50, (index) => 50 - index);
  int _playerPosition = 1; // Initial player position at "H"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Roll the Dice',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        AnimatedBubbles(),
        Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(_boardPadding),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _boardSize,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: _boardNumbers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int boardNumber = _boardNumbers[index];
                    String displayText;
                    if (boardNumber == 1) {
                      displayText = '🤡';
                    } else if (boardNumber == 50) {
                      displayText = 'WIN';
                    } else {
                      displayText = boardNumber.toString();
                    }
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        color:
                            index % 2 == 0 ? Colors.grey[500] : Colors.white70,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          if (boardNumber !=
                              _playerPosition) // Hide grid number if not player's position
                            Center(
                              child: Text(
                                displayText,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          if (boardNumber ==
                              _playerPosition) // Check if player position matches the current cell
                            AnimatedAlign(
                              duration: Duration(milliseconds: 500),
                              alignment: Alignment.center,
                              child: Icon(
                                size: 28,
                                Icons.pin_drop_outlined,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const ElevatedContainer(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Tap the dice to roll it. The number on the dice will be the number of tiles you move.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Dice(
              onDiceRolled: (int diceNumber) {
                _movePlayer(diceNumber);
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ]),
    );
  }

  void _movePlayer(int diceNumber) {
    setState(() {
      _playerPosition += diceNumber;
      if (_playerPosition > _boardNumbers.length) {
        _playerPosition = _boardNumbers.length;
      }
    });
  }
}
