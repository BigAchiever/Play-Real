import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/screens/home.dart';
import 'package:play_real/widgets/loader.dart';

import '../background.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

bool _isAnimationComplete = false;

class _HowToPlayState extends State<HowToPlay> {
  void _startAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isAnimationComplete =
          true; // setting boolean value to true after animation is complete
    });
  }

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      ),
      body: Stack(
        children: [
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

                  // the whole screen will be of same gradient
                  if (StartingScreenState.lightmodedarkmode == true)
                    StartingScreenState.lightmodedarkmode
                        ? lightGradientColor1
                        : gradientColor1,

                  // else the whole screen will have two gradient colors
                  if (StartingScreenState.lightmodedarkmode == false)
                    StartingScreenState.lightmodedarkmode
                        ? lightGradientColor2
                        : gradientColor2,
                ],
              ),
            ),
          ),
          _isAnimationComplete
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
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
                        const SizedBox(height: 16),
                        Image.asset(
                          "assets/images/dialogue_1.png",
                          height: 200,
                          width: 400,
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        Image.asset(
                          "assets/images/dialogue_2.png",
                          height: 200,
                          width: 400,
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        Image.asset(
                          "assets/images/grid.png",
                          height: 300,
                          width: 400,
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        Image.asset(
                          "assets/images/dice.png",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 16),
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
                        Image.asset(
                          "assets/images/message_box.jpg",
                          height: 200,
                          width: 400,
                        ),
                        const SizedBox(height: 16),
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
                        Image.asset(
                          "assets/images/done.png",
                          height: 100,
                          width: 100,
                        ),
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
                        Image.asset(
                          "assets/images/failed.png",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "8. The first player to reach the end point will be the winner.",
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
                )
              : const Center(
                  child: LoadingScreen(text: ""),
                ),
        ],
      ),
    );
  }
}
