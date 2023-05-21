import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_real/audio_player.dart';
import 'package:play_real/background.dart';
import 'package:play_real/dice.dart';
import 'package:play_real/difficulty_level.dart';
import 'package:play_real/loader.dart';
import 'board_sentences.dart';
import 'colors/color.dart';
import 'home.dart';
import 'message_card.dart';
import 'models/player.dart';
import 'utils/quitgame_dialogue.dart';
import 'utils/turnover_dialogue.dart';

class GameScreen extends StatefulWidget {
  final int numberOfPlayers;
  final int count;
  final int gridSize;
  final DifficultyLevel difficulty;

  const GameScreen({
    Key? key,
    required this.numberOfPlayers,
    required this.count,
    required this.gridSize,
    required this.difficulty,
  }) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final double _boardPadding = 12;
  late List<int> _boardNumbers;

  late List<Player> _players;

  int _currentPlayerIndex = 0;
  bool _isAnimationComplete = false;

  bool _isPlayerTurnComplete = false;
  bool _isDiceEnabled = true;
  bool _isDiceRolled = false;
  final AudioPlayerHelper audioPlayerHelper = AudioPlayerHelper();

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _initializePlayers(); // initializing players list
    _generateBoardNumbers();
    audioPlayerHelper.preloadAudio();
  }

  void PlayAudioDice() {
    audioPlayerHelper.playAudioDice();
  }

  void _initializePlayers() {
    _players = List.generate(
      widget.numberOfPlayers,
      (index) => Player(
        name: 'Player ${index + 1}',
        position: 1,
        color: getPlayerColor(index),
        number: index + 1, // Assign player number
      ),
    );
  }

  void _generateBoardNumbers() {
    _boardNumbers = List.generate(widget.gridSize * widget.gridSize, (index) {
      int boardNumber = widget.gridSize * widget.gridSize - index;
      return boardNumber;
    });
  }

  void _startAnimation() async {
    await Future.delayed(
        const Duration(seconds: 8)); // adding delay for animation

    if (mounted) {
      setState(() {
        _isAnimationComplete = true;
      });
    }
  }

  void _movePlayer(int diceNumber) {
    // Check if dice is enabled
    if (!_isDiceEnabled) {
      _showTurnOverDialog();
      return;
    }
    _isDiceRolled = true;
    final currentPlayer = _players[_currentPlayerIndex];
    final remainingSteps = _boardNumbers.length - currentPlayer.position;
    setState(() {
      if (remainingSteps < diceNumber) {
        // currentPlayer.position += remainingSteps;
        print(
            "noooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
      } else {
        currentPlayer.position += diceNumber;
      }
      if (currentPlayer.position > _boardNumbers.length) {
        currentPlayer.position = _boardNumbers.length;
      }

      _isDiceEnabled = false; // Disable the dice after rolling
    });
    _changePlayer();
  }

  //turnover_dialogue.dart
  void _showTurnOverDialog() {
    DialogUtils.showTurnOverDialog(context, () {
      setState(() {
        _isDiceEnabled = true; // Enabling  dice again
      });
    });
  }

  void _changePlayer() {
    if (_isPlayerTurnComplete) {
      setState(() {
        final currentPlayer = _players[_currentPlayerIndex];
        if (currentPlayer.position == _boardNumbers.length) {
          // Player has reached the last position and won the game
          _players.removeAt(_currentPlayerIndex);
          if (_players.length == 1) {
            // reset the game
            _initializePlayers();
            // show quit dialogue
            QuitDialog.showGameOverDialog(
              context,
            );
          }
          if (_currentPlayerIndex >= _players.length) {
            _currentPlayerIndex = 0; // Reset to the first player if necessary
          }
        } else {
          _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
        }
        _isPlayerTurnComplete = false;
        _isDiceRolled = false; // Reset the flag when the player changes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final currentPlayer = _players[_currentPlayerIndex];
    return WillPopScope(
      onWillPop: () async {
        QuitDialog.showGameOverDialog(
          context,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
              onPressed: () {
                QuitDialog.showGameOverDialog(
                  context,
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          backgroundColor: Colors.transparent.withOpacity(0.8),
          title: _isAnimationComplete
              ? _isDiceRolled
                  ? const Text(
                      'Complete your task!',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GameFont",
                          fontSize: 28),
                    )
                  : Text(
                      '${currentPlayer.name}\'s Turn',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "GameFont",
                        fontSize: 28,
                      ),
                    )
              : const Text(
                  'Play Real',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "GameFont",
                      fontSize: 28),
                ),
          centerTitle: true,
        ),
        body: Stack(children: [
          AnimatedBubbles(),
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.red.shade600.withOpacity(0.8),
                ],
              ),
            ),
          ),
          _isAnimationComplete
              ? Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(_boardPadding),
                        child: Stack(
                          children: [
                            // Grid View
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: widget.gridSize,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                ),
                                itemCount: _boardNumbers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final int boardNumber = _boardNumbers[index];
                                  String displayText;
                                  if (boardNumber == 1) {
                                    displayText = '💨';
                                  } else if (widget.gridSize == 10 &&
                                      boardNumber == 100) {
                                    displayText = '🌟';
                                  } else if (widget.gridSize == 7 &&
                                      boardNumber == 49) {
                                    displayText = "WIN";
                                  } else {
                                    displayText = boardNumber.toString();
                                  }
                                  final player = _players.firstWhere(
                                    (player) => player.position == boardNumber,
                                    orElse: () => Player(
                                      name: '',
                                      position: -1,
                                      color: Colors.transparent,
                                      number: index + 1,
                                    ),
                                  );
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: index % 2 == 0
                                          ? Colors.grey[400]
                                          : Colors.grey[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        if (player.position ==
                                            currentPlayer.position)
                                          Center(
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  Colors.green[700],
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  // Displaying the player token number
                                                  'P${currentPlayer.number.toString()}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "GameFont",
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (player.name.isEmpty)
                                          Center(
                                            child: Text(
                                              displayText,
                                              style: GoogleFonts.actor(
                                                fontSize: 18,
                                                letterSpacing: 1.2,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        if (player.position !=
                                                currentPlayer.position &&
                                            player.name.isNotEmpty)
                                          Center(
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  Colors.lightBlue[200],
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  // Displaying the player token number like P1, P2, P3, P4
                                                  'P${player.number.toString()}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "GameFont",
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.red,
                                                  ),
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 4.8,
                      child: ElevatedContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: _isDiceRolled
                                ? currentPlayer.position >= _boardNumbers.length
                                    ? Text(
                                        'Congratulations! Player ${currentPlayer.number} wins!',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.actor(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.greenAccent,
                                        ),
                                      )
                                    : Text(
                                        boardSentences[
                                            currentPlayer.position - 1],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.actor(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.greenAccent,
                                        ),
                                      )
                                : Text(
                                    'It\'s Player ${currentPlayer.number}\'s turn. Roll the dice!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.actor(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 90,
                          height: 50,
                          child: FloatingActionButton(
                            onPressed: () {
                              if (_isDiceRolled) {
                                setState(() {
                                  final currentPlayer =
                                      _players[_currentPlayerIndex];
                                  currentPlayer.position -=
                                      5; // 5 steps backward
                                  if (currentPlayer.position < 1) {
                                    currentPlayer.position = 1;
                                  }

                                  _isPlayerTurnComplete = true;
                                  _changePlayer();
                                  _isDiceEnabled = true;
                                  _isDiceRolled =
                                      false; // Reseting the dice rolled for the next player
                                });
                              } else {}
                            },
                            backgroundColor: Color.fromARGB(255, 105, 33, 28),
                            foregroundColor: Colors.white,
                            focusColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Failed 💀',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "GameFont",
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '(-5 Steps)',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[100],
                                          fontFamily: "GameFont"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Dice(
                          onDiceRolled: (int diceNumber) {
                            if (StartingScreenState.musicbutton) {
                              PlayAudioDice();
                            }
                            _movePlayer(diceNumber);
                          },
                          isEnabled: _isDiceEnabled,
                        ),
                        SizedBox(
                          width: 90,
                          height: 50,
                          child: FloatingActionButton(
                            onPressed: () {
                              if (_isDiceRolled) {
                                setState(() {
                                  _isPlayerTurnComplete = true;
                                  _changePlayer();
                                  _isDiceEnabled = true;
                                  _isDiceRolled =
                                      false; // the dice rolled flag will be reset for the next player
                                });
                              } else {}
                            },
                            backgroundColor: _isPlayerTurnComplete
                                ? Colors.grey
                                : const Color.fromARGB(255, 42, 181, 46),
                            foregroundColor: Colors.white,
                            focusColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Done 🥳',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "GameFont",
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : const LoadingScreen(
                  text:
                      "Discuss your turn number till the time we set up the game for you!",
                ),
          // Container(
          //   color: Colors.black.withOpacity(0.8),
          // ),
        ]),
      ),
    );
  }
}
