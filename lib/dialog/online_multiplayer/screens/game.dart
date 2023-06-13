import 'package:appwrite/appwrite.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/widgets/audio_player.dart';
import 'package:play_real/background.dart';
import 'package:play_real/widgets/dice.dart';
import 'package:play_real/widgets/loader.dart';
import 'package:play_real/dialog/utils/winning_dialogue.dart';
import '../../../constants/constants.dart';
import '../../../models/player.dart';
import '../../../network/game_server.dart';
import '../../../screens/home.dart';
import '../../../widgets/done.dart';
import '../../../widgets/failed_button.dart';
import '../../../widgets/message_card.dart';
import '../../../widgets/tasks/board_sentences.dart';
import '../../utils/quitgame_dialogue.dart';
import '../../utils/turnover_dialogue.dart';

class OnlineGameScreen extends StatefulWidget {
  final String gameSessionId;
  final String movesId;

  const OnlineGameScreen({
    Key? key,
    required this.gameSessionId,
    required this.movesId,
  }) : super(key: key);

  @override
  _OnlineGameScreenState createState() => _OnlineGameScreenState();
}

class _OnlineGameScreenState extends State<OnlineGameScreen> {
  final double _boardPadding = 12;
  late List<int> _boardNumbers;

  late List<Player> _players = [];
  late ConfettiController _confettiController;
  int _gridSize = 7;

  int _currentPlayerIndex = 0;
  bool _isAnimationComplete = false;

  bool _isPlayerTurnComplete = false;
  bool _isDiceEnabled = true;
  bool _isDiceRolled = false;
  final AudioPlayerHelper audioPlayerHelper = AudioPlayerHelper();
  RealtimeSubscription? subscription;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _initializePlayers(); // initializing players list
    _generateBoardNumbers();
    audioPlayerHelper.preloadAudio();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _subscribeToRealtimeEvents();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    subscription?.close();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  void PlayAudioDice() {
    audioPlayerHelper.playAudioDice();
  }

  void _initializePlayers() async {
    final movesId = widget.movesId;

    final currentMovesData = await databases.getDocument(
      collectionId: movesCollectionId,
      documentId: movesId,
      databaseId: databaseId,
    );

    final player1Position = currentMovesData.data['player1Position'];
    final player2Position = currentMovesData.data['player2Position'];

    setState(() {
      _players = [
        Player(name: 'Player 1', position: player1Position, number: 1),
        Player(name: 'Player 2', position: player2Position, number: 2),
      ];
    });
  }

  void _generateBoardNumbers() async {
    final gameSessionId = widget.gameSessionId;
    final gameSessionData = await getGameSession(gameSessionId);

    final gridSize = gameSessionData['gridSize'] as int;

    setState(() {
      _gridSize = gridSize;
      _boardNumbers = List.generate(gridSize * gridSize, (index) {
        int boardNumber = gridSize * gridSize - index;
        return boardNumber;
      });
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
    if (!_isDiceEnabled) {
      _showTurnOverDialog();
      return;
    }
    _isDiceRolled = true;
    final currentPlayer = _players[_currentPlayerIndex];
    final remainingSteps = _boardNumbers.length - currentPlayer.position;

    int newPosition;
    if (remainingSteps < diceNumber) {
      newPosition = currentPlayer.position + remainingSteps;
      if (kDebugMode) {
        print(
            "noooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
      }
    } else {
      newPosition = currentPlayer.position + diceNumber;
    }
    if (newPosition > _boardNumbers.length) {
      newPosition = _boardNumbers.length;
    }

    setState(() {
      currentPlayer.position = newPosition;
      _isDiceEnabled = false; // Disable the dice after rolling
    });

    // Update player positions in the backend
    _updatePlayerPositions(
      widget.movesId,
      _players[0].position,
      _players[1].position,
    );

    _changePlayer();
  }

  void _subscribeToRealtimeEvents() {
    final movesId = widget.movesId;

    subscription = realtime.subscribe(
      [
        'database.${databaseId}.collection.${movesCollectionId}.document.${movesId}}'
      ],
    );
    subscription!.stream.listen(
      (data) {
        if (data.events.contains(
            'database${databaseId}.collection.${movesCollectionId}.document.${movesId}.update')) {
          print(
              '----------------------------${data}////////////////////////////////////////');

          setState(() {
            _players[0].position = data.payload['player1Position'];

            _players[1].position = data.payload['player2Position'];
          });
        }
      },
      cancelOnError: true,
      onDone: () {
        print('Realtime subscription closed');
      },
    );
  }

  Future<void> _updatePlayerPositions(
    String movesId,
    int player1Position,
    int player2Position,
  ) async {
    // Update the player positions in the backend
    await databases.updateDocument(
      collectionId: movesCollectionId,
      documentId: movesId,
      data: {
        "player1Position": _players[0].position,
        "player2Position": _players[1].position,
      },
      databaseId: databaseId,
    );
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

      // Update player positions in the backend
      _updatePlayerPositions(
        widget.movesId,
        _players[0].position,
        _players[1].position,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (_players.isEmpty) {
      // Show loading indicator while players are being initialized
      return Center(
        child: LoadingScreen(
          text: 'Connecting...',
        ),
      );
    }

    final currentPlayer =
        _players.isNotEmpty ? _players[_currentPlayerIndex] : null;
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
                      '${currentPlayer?.name}\'s Turn',
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
                                    crossAxisCount:
                                        _gridSize, // Grid Size fetched from backedn!
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
                                    } else if (_gridSize == 10 &&
                                        boardNumber == 100) {
                                      displayText = '🌟';
                                    } else if (_gridSize == 7 &&
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
                                              currentPlayer?.position)
                                            Center(
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    currentPlayerColor,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    // Displaying the player token number
                                                    'P${currentPlayer?.number.toString()}',
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
                                                  currentPlayer?.position &&
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
                                  ? currentPlayer != null &&
                                          currentPlayer.position >=
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
                                              currentPlayer!.position - 1],
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
                                      'It\'s Player ${currentPlayer?.number}\'s turn. Roll the dice!',
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
                          FailedButton(
                            isEnabled: _isDiceRolled,
                            onPressed: () {
                              setState(() {
                                final currentPlayer =
                                    _players[_currentPlayerIndex];
                                currentPlayer.position -= 5; // 5 steps backward
                                if (currentPlayer.position < 1) {
                                  currentPlayer.position = 1;
                                }
                                _isPlayerTurnComplete = true;
                                _changePlayer();
                                _isDiceEnabled = true;
                                _isDiceRolled =
                                    false; // Resetting the dice rolled for the next player
                              });
                            },
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
                          DoneButton(
                            isEnabled: _isDiceRolled,
                            onPressed: () {
                              setState(() {
                                _isPlayerTurnComplete = true;
                                _changePlayer();
                                _isDiceEnabled = true;
                                _isDiceRolled =
                                    false; // The dice rolled flag will be reset for the next player
                              });
                            },
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
