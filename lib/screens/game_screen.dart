import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/widgets/audio_player.dart';
import 'package:play_real/background.dart';
import 'package:play_real/widgets/dice.dart';
import 'package:play_real/dialog/widgets/difficulty_level.dart';
import 'package:play_real/widgets/loader.dart';
import 'package:play_real/dialog/dialog_utils/winning_dialogue.dart';
import '../config/player_colors.dart';
import '../widgets/tasks/board_sentences.dart';
import 'home.dart';
import '../widgets/message_card.dart';
import '../models/player.dart';
import '../dialog/dialog_utils/quitgame_dialogue.dart';
import '../dialog/dialog_utils/turnover_dialogue.dart';

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
  late ConfettiController _confettiController;

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
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
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
        if (kDebugMode) {
          print(
              "noooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
        }
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
            // Reset the game and show game over dialog
            _initializePlayers();
            _confettiController.play();
            GameWonDialog.showGameWonDialog(
              context,
              currentPlayer.number,
            );
          } else {
            // Show game won dialog and check if current player index needs to be reset
            _confettiController.play();
            GameWonDialog.showGameWonDialog(
              context,
              currentPlayer.number,
            );

            if (_currentPlayerIndex >= _players.length) {
              _currentPlayerIndex = 0; // Reset to the first player if necessary
            }
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
              icon: Icon(
                Icons.arrow_back_ios,
                color: buttonForegroundColor,
                size: 18,
              ),
            ),
          ),
          backgroundColor: StartingScreenState.lightmodedarkmode
              ? lightGradientColor1
              : gradientColor1,
          title: _isAnimationComplete
              ? _isDiceRolled
                  ? Text(
                      'Complete your task!',
                      style: TextStyle(
                          color: buttonForegroundColor,
                          fontFamily: "GameFont",
                          fontSize: 30),
                    )
                  : Text(
                      '${currentPlayer.name}\'s Turn',
                      style: TextStyle(
                        color: buttonForegroundColor,
                        fontFamily: "GameFont",
                        fontSize: 30,
                      ),
                    )
              : Text(
                  'Play Real',
                  style: TextStyle(
                      color: buttonForegroundColor,
                      fontFamily: "GameFont",
                      fontSize: 30),
                ),
          centerTitle: true,
        ),
        body: ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          emissionFrequency: 0.05,
          numberOfParticles: 20,
          gravity: 0.1,
          shouldLoop: false,
          colors: const [
            Colors.blue,
            Colors.purple,
            Colors.pink,
            Colors.orange,
            Colors.yellow,
            Colors.green,
          ],
          child: Stack(children: [
            const AnimatedBubbles(),
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    StartingScreenState.lightmodedarkmode
                        ? lightGradientColor1
                        : gradientColor1,
                    StartingScreenState.lightmodedarkmode
                        ? lightGradientColor2
                        : gradientColor2,
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final int boardNumber =
                                        _boardNumbers[index];
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
                                      (player) =>
                                          player.position == boardNumber,
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
                                        color: StartingScreenState
                                                .lightmodedarkmode
                                            ? index % 2 == 0
                                                ? lightGridColorOdd
                                                : gridColorEven
                                            : index % 2 == 0
                                                ? gridColorOdd
                                                : gridColorEven,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
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
                                                    currentPlayerColor,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    // Displaying the player token number
                                                    'P${currentPlayer.number.toString()}',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "GameFont",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          currentPlayerTextColor,
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
                                                  color: gridTextColor,
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
                                                    commonPlayerColor,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    // Displaying the player token number like P1, P2, P3, P4
                                                    'P${player.number.toString()}',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "GameFont",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          commonPlayerTextColor,
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
                        height: size.height / 4.5,
                        child: ElevatedContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                // Displaying the message
                              child: _isDiceRolled 
                                  ? currentPlayer.position >=
                                          _boardNumbers.length
                                      ? Text(
                                        // Displaying the message when the player wins
                                          'Congratulations! Player ${currentPlayer.number} wins! Press Done to continue.',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.actor(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: StartingScreenState
                                                    .lightmodedarkmode
                                                ? Colors.amber
                                                : messageColor,
                                          ),
                                        )
                                      : Text(
                                        // Displaying the board sentences when the player moves on a particular tile
                                          boardSentences[
                                              currentPlayer.position - 1],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.actor(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: StartingScreenState
                                                    .lightmodedarkmode
                                                ? lightMessageColor
                                                : messageColor,
                                          ),
                                        )
                                  : Text(
                                      // Current player's turn message
                                      'It\'s Player ${currentPlayer.number}\'s turn. Roll the dice!',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.actor(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: StartingScreenState
                                                .lightmodedarkmode
                                            ? lightMessageColor
                                            : messageColor,
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
                          // ---------------------------Failed Button ---------------------------
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
                              backgroundColor:
                                  StartingScreenState.lightmodedarkmode
                                      ? lightFailedColor
                                      : failedColor,
                              foregroundColor: buttonForegroundColor,
                              focusColor: commonGreyColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Failed 💀',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "GameFont",
                                            color: StartingScreenState
                                                    .lightmodedarkmode
                                                ? lightbuttonForegroundColor
                                                : buttonForegroundColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '(-5 Steps)',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: StartingScreenState
                                                    .lightmodedarkmode
                                                ? lightbuttonForegroundColor
                                                : buttonForegroundColor,
                                            fontFamily: "GameFont"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ----------------------------Dice widget called here--------------------------------
                          Dice(
                            onDiceRolled: (int diceNumber) {
                              if (StartingScreenState.musicbutton) {
                                PlayAudioDice();
                              }
                              _movePlayer(diceNumber);
                            },
                            isEnabled: _isDiceEnabled,
                          ),

                          //-------------------------------- Done button here--------------------------------
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
                              backgroundColor:
                                  StartingScreenState.lightmodedarkmode
                                      ? lightSuccessColor
                                      : successColor,
                              foregroundColor: buttonForegroundColor,
                              focusColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Done 😎',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "GameFont",
                                      color:
                                          StartingScreenState.lightmodedarkmode
                                              ? lightbuttonForegroundColor
                                              : buttonForegroundColor,
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
      ),
    );
  }
}
