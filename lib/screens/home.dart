import 'dart:async';
import 'package:flutter/material.dart';
import 'package:play_real/background.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/dialog/game_detail_dialogue.dart';
import 'package:play_real/dialog/settings.dart';
import 'package:play_real/widgets/home_icon_button.dart';
import 'package:play_real/widgets/home_screen_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/audio_player.dart';
import 'how_to_play.dart';
import '../widgets/loader.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => StartingScreenState();
}

class StartingScreenState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  Shader createGameTextureShader(Rect rect) {
    final gradient = LinearGradient(
      colors: [Colors.yellow, Colors.green, Colors.white],
    );
    return gradient.createShader(rect);
  }

  // assign a controller to the animation
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  static bool musicbutton = true;
  static bool lightmodedarkmode = false;
  bool isFacebookLoggedIn = false;
  bool showComingSoon = false;

  final AudioPlayerHelper audioPlayerHelper = AudioPlayerHelper();
  final supabase = Supabase.instance.client;
  @override
  void initState() {
    super.initState();
    audioPlayerHelper.preloadAudio();
  }

  void playAudio() {
    audioPlayerHelper.playAudio();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Facebbok login using supabase here
  Future<void> _facebookLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final isPreviouslyLoggedIn = prefs.getBool('isFacebookLoggedIn') ?? false;
    if (isFacebookLoggedIn || isPreviouslyLoggedIn) {
      // User is authenticated, ontap sign out
      await supabase.auth.signOut();
      setState(() {
        isFacebookLoggedIn = false;
      });
    } else {
      supabase.auth.signInWithOAuth(
        Provider.facebook,
      );
      setState(() {
        isFacebookLoggedIn = true;
        prefs.setBool('isFacebookLoggedIn', true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                lightmodedarkmode ? lightGradientColor1 : gradientColor1,
                lightmodedarkmode ? lightGradientColor2 : gradientColor2,
              ],
            ),
          ),
        ),
        const AnimatedBubbles(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: size.height / 24,
              ),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return createGameTextureShader(bounds);
                },
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    const ropeHeight = 10.0;
                    final translateY =
                        ropeHeight * _controller.value - ropeHeight / 2;
                    return Transform.translate(
                      offset: Offset(0, translateY),
                      child: child,
                    );
                  },
                  child: Text(
                    "PLAY REAL",
                    style: TextStyle(
                      fontSize: size.width / 5,
                      fontFamily: "GameFont",
                      fontWeight: FontWeight.w500,
                      color: lightmodedarkmode
                          ? lightbuttonForegroundColor
                          : buttonForegroundColor,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 0,
                          offset: Offset(0, 4),
                        ),
                        Shadow(
                          color: Colors.blue,
                          blurRadius: 0,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CustomIconButton(
                          onPressed: () {
                            setState(() {
                              musicbutton = !musicbutton;
                            });
                            if (musicbutton) {
                              playAudio();
                            }
                          },
                          child: Icon(
                            musicbutton ? Icons.music_note : Icons.music_off,
                            color: lightmodedarkmode
                                ? lightbuttonForegroundColor
                                : buttonForegroundColor,
                          ),
                        ),
                        CustomIconButton(
                          onPressed: () {
                            if (musicbutton) {
                              playAudio();
                            }
                          },
                          child: Icon(
                            Icons.leaderboard,
                            color: lightmodedarkmode
                                ? lightbuttonForegroundColor
                                : buttonForegroundColor,
                          ),
                        ),
                        CustomIconButton(
                          onPressed: () {
                            if (musicbutton) {
                              playAudio();
                            }
                            setState(() {
                              lightmodedarkmode = !lightmodedarkmode;
                            });
                          },
                          child: Icon(
                            lightmodedarkmode
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: lightmodedarkmode
                                ? lightbuttonForegroundColor
                                : buttonForegroundColor,
                          ),
                        ),
                        CustomIconButton(
                          onPressed: () {
                            if (musicbutton) {
                              playAudio();
                            }
                            _facebookLogin();
                          },
                          child: Image.asset(
                            isFacebookLoggedIn
                                ? "assets/images/facebook.png"
                                : "assets/images/not_facebook.png",
                            color: lightmodedarkmode
                                ? lightbuttonForegroundColor
                                : buttonForegroundColor,
                            height: isFacebookLoggedIn ? 24 : 48,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height / 18),
              HomeScreenButton(
                onPressed: () {
                  if (musicbutton) {
                    playAudio();
                  }

                  showDialog(
                    context: context,
                    builder: (context) {
                      return FutureBuilder(
                        future:
                            Future.delayed(const Duration(milliseconds: 200)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return const GameDialog();
                          } else {
                            return const LoadingScreen(
                              text: 'Loading...',
                            );
                          }
                        },
                      );
                    },
                  );
                },
                child: const Text(
                  'Start Game 🎭',
                  style: TextStyle(
                      fontFamily: 'GameFont', fontSize: 30, letterSpacing: 1.1),
                ),
              ),
              HomeScreenButton(
                onPressed: () {
                  if (musicbutton) {
                    playAudio();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HowToPlay(),
                    ),
                  );
                },
                child: const Text(
                  'How to Play?',
                  style: TextStyle(
                      fontFamily: "GameFont", fontSize: 28, letterSpacing: 1.1),
                ),
              ),
              HomeScreenButton(
                onPressed: () {
                  if (musicbutton) {
                    playAudio();
                  }
                  setState(() {
                    showComingSoon = true;
                    Future.delayed(const Duration(seconds: 3), () {
                      setState(() {
                        showComingSoon = false;
                      });
                    });
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: showComingSoon ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        'Coming Soon!',
                        style: TextStyle(
                            fontFamily: "GameFont",
                            fontSize: 28,
                            letterSpacing: 1.1),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: showComingSoon ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        'Online Multiplayer',
                        style: TextStyle(
                            fontFamily: "GameFont",
                            fontSize: 28,
                            letterSpacing: 1.1),
                      ),
                    ),
                  ],
                ),
              ),
              HomeScreenButton(
                onPressed: () {
                  if (musicbutton) {
                    playAudio();
                  }

                  showDialog(
                    context: context,
                    builder: (context) {
                      return FutureBuilder(
                        future:
                            Future.delayed(const Duration(milliseconds: 200)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return const SettingsScreen(
                              avatarImageUrl: '',
                              gameDetails: 'Beginner',
                              playerName: 'Player 1',
                            );
                          } else {
                            return const LoadingScreen(
                              text: 'Loading...',
                            );
                          }
                        },
                      );
                    },
                  );
                },
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: "GameFont",
                    fontSize: 28,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
