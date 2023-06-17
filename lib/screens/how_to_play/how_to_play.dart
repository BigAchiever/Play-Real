import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/dialog/widgets/difficulty_widget.dart';
import 'package:play_real/dialog/widgets/player_widget.dart';
import 'package:play_real/screens/home.dart';

import 'package:play_real/widgets/blur_screen_widget.dart';
import 'package:play_real/widgets/dice.dart';
import 'package:play_real/widgets/failed_button.dart';
import 'package:play_real/widgets/loader.dart';
import 'package:play_real/widgets/message_card.dart';

import '../../background.dart';
import '../../widgets/done.dart';
import 'how_top_play_online.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

bool _isAnimationComplete = false;
late TabController _tabController;
late PageController _pageController;
int _currentIndex = 0;

class _HowToPlayState extends State<HowToPlay> with TickerProviderStateMixin {
  void _startAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted)
      setState(() {
        _isAnimationComplete =
            true; // setting boolean value to true after animation is complete
      });
  }

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _tabController = TabController(length: 2, vsync: this); // switching tabs
    _pageController = PageController(initialPage: 0, viewportFraction: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: StartingScreenState.lightmodedarkmode
              ? lightGradientColor1
              : gradientColor1,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: textColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "How to Play",
            style: TextStyle(
              fontSize: 30,
              fontFamily: "GameFont",
              fontWeight: FontWeight.w500,
              color: StartingScreenState.lightmodedarkmode
                  ? Colors.tealAccent
                  : textColor,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            splashBorderRadius: BorderRadius.zero,
            splashFactory: NoSplash.splashFactory,
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  _currentIndex,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                );
              });
            },
            indicatorColor: StartingScreenState.lightmodedarkmode
                ? lightBorderColor
                : borderColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(
              fontSize: 18,
              fontFamily: "GameFont",
              fontWeight: FontWeight.w500,
              color: StartingScreenState.lightmodedarkmode
                  ? Colors.tealAccent
                  : textColor,
            ),
            tabs: [
              Tab(
                text: 'Local',
              ),
              Tab(text: 'Online'),
            ],
          ),
        ),
        body: Stack(
          children: [
            const AnimatedBubbles(),
            blurScreenWidget(context),
            _isAnimationComplete
                ? PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      _tabController.animateTo(
                        index,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.ease,
                      );
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "1. Choose the number of players and select the difficulty level. It will assign the number of tokens for each player. ",
                                style: GoogleFonts.actor(
                                  fontSize: 18,
                                  // fontFamily: "DragonHunters",
                                  fontWeight: FontWeight.w600,
                                  color: StartingScreenState.lightmodedarkmode
                                      ? Colors.tealAccent
                                      : textColor,
                                ),
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: 250,
                                child: PlayerCountSelectionWidget(
                                  onPlayerCountChanged: (int value) {},
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "2. The difficulty level will determine the type of questions you will be asked.\n Default - Combination of all levels\n Kids - Fun Tasks for kids\n Medium - Tasks for teens and adults\n Sarcastic - God level tasks - Hard to complete",
                                style: GoogleFonts.actor(
                                  fontSize: 18,
                                  // fontFamily: "DragonHunters",
                                  fontWeight: FontWeight.w600,
                                  color: StartingScreenState.lightmodedarkmode
                                      ? lightbuttonForegroundColor
                                      : textColor,
                                ),
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: 250,
                                child: DifficultySelectionWidget(
                                  onDifficultyChanged: (p0) {},
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "3.  After you click 'Start Game' the game will start with all players on the initial point of the board. Players can decide the order of their turns by themselves.",
                                style: GoogleFonts.actor(
                                  fontSize: 18,
                                  // fontFamily: "DragonHunters",
                                  fontWeight: FontWeight.w600,
                                  color: StartingScreenState.lightmodedarkmode
                                      ? lightbuttonForegroundColor
                                      : textColor,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Image.asset(
                                "assets/images/grid.png",
                                height: 300,
                                width: 400,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "4.  There is a red color die on the screen. You can roll the die by tapping on it. The number on the die will determine the number of steps you can take.",
                                style: GoogleFonts.actor(
                                  fontSize: 18,
                                  // fontFamily: "DragonHunters",
                                  fontWeight: FontWeight.w600,
                                  color: StartingScreenState.lightmodedarkmode
                                      ? lightbuttonForegroundColor
                                      : textColor,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Dice(
                                  onDiceRolled: (diceNumber) {
                                    print("Dice number: $diceNumber");
                                  },
                                  isEnabled: true),
                              const SizedBox(height: 30),
                              Text(
                                "5. There is a task on each step. When your player moves, the task will be displayed on the message box.",
                                style: GoogleFonts.actor(
                                  fontSize: 18,
                                  // fontFamily: "DragonHunters",
                                  fontWeight: FontWeight.w600,
                                  color: StartingScreenState.lightmodedarkmode
                                      ? lightbuttonForegroundColor
                                      : textColor,
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 180,
                                child: ElevatedContainer(
                                  child: Center(
                                    child: Text(
                                      // Current player's turn message
                                      "Your task will be displayed here",
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
                              const SizedBox(height: 30),
                              Text(
                                "6. You have to complete the task whatever it is. After you complete the task you can press Done button and then comes the chance of the next player.",
                                style: GoogleFonts.actor(
                                  fontSize: 18,
                                  // fontFamily: "DragonHunters",
                                  fontWeight: FontWeight.w600,
                                  color: StartingScreenState.lightmodedarkmode
                                      ? lightbuttonForegroundColor
                                      : textColor,
                                ),
                              ),
                              DoneButton(isEnabled: true, onPressed: () {}),
                              const SizedBox(height: 16),
                              Text(
                                "7. If you are unable to complete the task, you can press the failed button and then you will move 5 steps back.",
                                style: GoogleFonts.actor(
                                  fontSize: 18,
                                  // fontFamily: "DragonHunters",
                                  fontWeight: FontWeight.w600,
                                  color: StartingScreenState.lightmodedarkmode
                                      ? lightbuttonForegroundColor
                                      : textColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              FailedButton(isEnabled: true, onPressed: () {}),
                              const SizedBox(height: 16),
                              Text(
                                "8. The first player to reach the end point will be the winner of the Game. Hope you had fun playing the game. Enjoy!",
                                style: GoogleFonts.actor(
                                  fontSize: 18,
                                  // fontFamily: "DragonHunters",
                                  fontWeight: FontWeight.w600,
                                  color: StartingScreenState.lightmodedarkmode
                                      ? lightbuttonForegroundColor
                                      : textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      howToPlayOnline(),
                    ],
                  )
                : const Center(
                    child: LoadingScreen(text: "Loading..."),
                  ),
          ],
        ),
      ),
    );
  }
}
