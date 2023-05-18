import 'package:flutter/material.dart';
import 'package:play_real/background.dart';
import 'package:play_real/dice.dart';
import 'package:play_real/loader.dart';
import 'colors/color.dart';
import 'message_card.dart';
import 'models/player.dart';

class GameScreen extends StatefulWidget {
  final int numberOfPlayers;

  const GameScreen({Key? key, required this.numberOfPlayers}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int _boardSize = 7;
  final double _boardPadding = 16;
  final List<int> _boardNumbers = List.generate(50, (index) => 50 - index);

  late List<Player> _players;

  int _currentPlayerIndex = 0;
  bool _isAnimationComplete = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _initializePlayers(); // initializing players list
  }

  void _initializePlayers() {
    _players = List.generate(
      widget.numberOfPlayers,
      (index) => Player(
        name: 'Player ${index + 1}',
        position: 1,
        color: getPlayerColor(index),
      ),
    );
  }

  void _startAnimation() async {
    await Future.delayed(
        const Duration(seconds: 5)); // adding delay for animation
    setState(() {
      _isAnimationComplete =
          true; // setting boolean value to true after animation is complete
    });
  }

  void _movePlayer(int diceNumber) {
    final currentPlayer = _players[_currentPlayerIndex];
    setState(() {
      currentPlayer.position += diceNumber;
      if (currentPlayer.position > _boardNumbers.length) {
        currentPlayer.position = _boardNumbers.length;
      }
    });
    _changePlayer();
  }

  void _changePlayer() {
    setState(() {
      _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPlayer = _players[_currentPlayerIndex];
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: _isAnimationComplete
            ? Text(
                '${currentPlayer.name}\'s Turn',
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : const Text(
                'Play Real',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
        centerTitle: true,
      ),
      body: Stack(children: [
        AnimatedBubbles(),
        _isAnimationComplete
            ? Column(
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
                            displayText = '💨';
                          } else if (boardNumber == 50) {
                            displayText = 'WIN';
                          } else {
                            displayText = boardNumber.toString();
                          }
                          final player = _players.firstWhere(
                            (player) => player.position == boardNumber,
                            orElse: () => Player(
                              name: '',
                              position: -1,
                              color: Colors.transparent,
                            ),
                          );
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              color: index % 2 == 0
                                  ? Colors.grey[500]
                                  : Colors.white70,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                if (player.name.isEmpty)
                                  Center(
                                    child: Text(
                                      displayText,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                if (player.position == currentPlayer.position)
                                  Center(
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.black,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          size: 28,
                                          Icons.pin_drop_outlined,
                                          color: currentPlayer.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (player.position != currentPlayer.position &&
                                    player.name.isNotEmpty)
                                  Center(
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          size: 28,
                                          Icons.pin_drop_outlined,
                                          color: player.color,
                                        ),
                                      ),
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
              )
            : const LoadingScreen(
                text: "Good Luck! Your game will be started shortly",
              ),
      ]),
    );
  }
}
