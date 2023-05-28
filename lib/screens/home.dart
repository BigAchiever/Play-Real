import 'dart:async';

import 'package:flutter/material.dart';
import 'package:play_real/background.dart';
import 'package:play_real/config/theme/themedata.dart';
import 'package:play_real/constants/constants.dart';
import 'package:play_real/dialog/start_game_dialog.dart';
import 'package:play_real/dialog/settings.dart';
import 'package:play_real/widgets/error_widget.dart';
import 'package:play_real/widgets/home_icon_button.dart';
import 'package:play_real/widgets/home_screen_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appwrite/auth.dart';
import '../widgets/audio_player.dart';

import '../widgets/loader.dart';
import 'how_to_play/how_to_play.dart';

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
  // final account = Account(client);

  static const String kMusicButtonKey = 'musicButton';
  static const String kLightModeDarkModeKey = 'lightModeDarkMode';
  static const String kfacebookLoginKey = 'facebookLogin';

  @override
  void initState() {
    super.initState();
    audioPlayerHelper.preloadAudio();
    _loadSavedState();
  }

  void playAudio() {
    audioPlayerHelper.playAudio();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kMusicButtonKey, musicbutton);
    await prefs.setBool(kLightModeDarkModeKey, lightmodedarkmode);
    await prefs.setBool(kfacebookLoginKey, isFacebookLoggedIn);
  }

  // Loading saved states
  Future<void> _loadSavedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      musicbutton = prefs.getBool(kMusicButtonKey) ?? true;
      lightmodedarkmode = prefs.getBool(kLightModeDarkModeKey) ?? false;
      isFacebookLoggedIn = prefs.getBool(kfacebookLoginKey) ?? false;
    });
    context.read<AuthAPI>().isFacebookAuthenticated.value = isFacebookLoggedIn;
  }

  // calling sign in with rpovider form auth_api.art
  signInWithFacebook(String provider) {
    if (context.read<AuthAPI>().isFacebookAuthenticated.value) {
      // already logged in, sign out
      try {
        context.read<AuthAPI>().signOut();
        showError(context, 'Signed out of Facebook');
      } catch (e) {
        print('Error signing out: $e');
        showError(context, 'There was an error signing out');
      } finally {
        isFacebookLoggedIn = false;
        context.read<AuthAPI>().isFacebookAuthenticated.value = false;
        _saveState();
      }
    } else {
      // not logged in, sign in
      try {
        context.read<AuthAPI>().signInWithFacebook(provider: provider);
      } catch (e) {
        print('Error signing in: $e');
        showError(context, 'There was an error signing in');
      } finally {
        isFacebookLoggedIn = true;
        context.read<AuthAPI>().isFacebookAuthenticated.value = true;
        _saveState();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
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
                      "PLAY\n    REAL",
                      style: TextStyle(
                        fontSize: size.width > mobileScreenWidth ? 100 : 80,
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
                            color: Colors.black,
                            blurRadius: 0,
                            offset: Offset(0, -6),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                _saveState();
                              });
                              if (musicbutton) {
                                playAudio();
                              }
                            },
                            heroTag: Text("music"),
                            child: Icon(
                              musicbutton ? Icons.music_note : Icons.music_off,
                              color: lightmodedarkmode
                                  ? lightbuttonForegroundColor
                                  : buttonForegroundColor,
                            ),
                          ),
                          CustomIconButton(
                            heroTag: Text("leaderboard"),
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
                                _saveState();
                              });
                            },
                            heroTag: Text("lightmode"),
                            child: Icon(
                              lightmodedarkmode
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              color: lightmodedarkmode
                                  ? lightbuttonForegroundColor
                                  : buttonForegroundColor,
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable:
                                context.read<AuthAPI>().isFacebookAuthenticated,
                            builder: (BuildContext context,
                                bool isFacebookAuthenticated, Widget? child) {
                              return CustomIconButton(
                                onPressed: () async {
                                  if (musicbutton) {
                                    playAudio();
                                  }
                                  signInWithFacebook('facebook');
                                  _saveState();
                                },
                                heroTag: Text("facebook"),
                                child: Image.asset(
                                  isFacebookAuthenticated
                                      ? "assets/images/facebook.png"
                                      : "assets/images/not_facebook.png",
                                  color: lightmodedarkmode
                                      ? lightbuttonForegroundColor
                                      : buttonForegroundColor,
                                  height: isFacebookAuthenticated ? 24 : 48,
                                ),
                              );
                            },
                          ),
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
                        fontFamily: 'GameFont',
                        fontSize: 30,
                        letterSpacing: 1.1),
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
                        fontFamily: "GameFont",
                        fontSize: 28,
                        letterSpacing: 1.1),
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
                    // use future builer
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FutureBuilder(
                            future: Future.delayed(
                                const Duration(milliseconds: 200)),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return SettingsScreen();
                              } else {
                                return LoadingScreen(
                                  text: 'Loading...',
                                );
                              }
                            },
                          );
                        });
                  },
                  child: const Text(
                    'Profile',
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
          
        ],
      ),
    );
  }
}
