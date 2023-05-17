import 'package:flutter/material.dart';
import 'package:play_real/background.dart';

import 'game_screen.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => StartingScreenState();
}

class StartingScreenState extends State<StartingScreen> {
  Shader createGameTextureShader(Rect rect) {
    final gradient = LinearGradient(
      colors: [Colors.yellow, Colors.red],
    );
    return gradient.createShader(rect);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        AnimatedBubbles(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height / 9,
              ),
              ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return createGameTextureShader(bounds);
                  },
                  child: const Text(
                    "PLAY REAL",
                    style: TextStyle(
                      fontSize: 70,
                      fontFamily: "GameFont",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )),
              SizedBox(height: size.height / 3),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Start Game',
                    style: TextStyle(fontFamily: "GameFont", fontSize: 24),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'How to Play?',
                    style: TextStyle(fontFamily: "GameFont", fontSize: 24),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Online Multiplayer',
                    style: TextStyle(fontFamily: "GameFont", fontSize: 24),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Settings',
                    style: TextStyle(fontFamily: "GameFont", fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
