import 'package:flutter/material.dart';
import 'package:play_real/background.dart';
import 'package:play_real/dialogue.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => StartingScreenState();
}

class StartingScreenState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  Shader createGameTextureShader(Rect rect) {
    const gradient = LinearGradient(
      colors: [Colors.yellow, Colors.green, Colors.white],
    );
    return gradient.createShader(rect);
  }

  // assign a controller to the animation
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  bool musicbutton = false;
  bool voice = false;
  bool lightmodedarkmode = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final ropeHeight = 20.0; // Height of the rope
                  final translateY =
                      (_controller.value * ropeHeight) - ropeHeight;
                  return Transform.translate(
                    offset: Offset(0, translateY),
                    child: child,
                  );
                },
                child: const Text(
                  "PLAY REAL",
                  style: TextStyle(
                    fontSize: 80,
                    fontFamily: "GameFont",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    shadows: [
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: size.width / 8,
                        child: FloatingActionButton(
                          heroTag: "btn1",
                          shape: const CircleBorder(
                              side: BorderSide(color: Colors.black, width: 3)),
                          onPressed: () {
                            setState(() {
                              musicbutton = !musicbutton;
                            });
                          },
                          child: Icon(
                            musicbutton ? Icons.music_off : Icons.music_note,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 8,
                        child: FloatingActionButton(
                          heroTag: "btn2",
                          shape: const CircleBorder(
                              side: BorderSide(color: Colors.black, width: 3)),
                          onPressed: () {
                            setState(() {
                              voice = !voice;
                            });
                          },
                          child: Icon(
                            voice ? Icons.volume_off : Icons.volume_up,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 8,
                        child: FloatingActionButton(
                          heroTag: "btn3",
                          shape: const CircleBorder(
                              side: BorderSide(color: Colors.black, width: 3)),
                          onPressed: () {
                            setState(() {
                              lightmodedarkmode = !lightmodedarkmode;
                            });
                          },
                          child: Icon(
                            lightmodedarkmode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height / 9),
            SizedBox(
              height: 60,
              width: 230,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const GameDialog(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  elevation: 0,
                  visualDensity: VisualDensity.standard,
                ),
                child: const Text(
                  'Start Game 🎭',
                  style: TextStyle(fontFamily: "GameFont", fontSize: 30),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'How to Play?',
                  style: TextStyle(fontFamily: "GameFont", fontSize: 28),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  elevation: 0,
                  visualDensity: VisualDensity.standard,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 260,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Online Multiplayer',
                  style: TextStyle(fontFamily: "GameFont", fontSize: 28),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  elevation: 0,
                  visualDensity: VisualDensity.standard,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: "GameFont",
                    fontSize: 28,
                    letterSpacing: 1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  elevation: 0,
                  visualDensity: VisualDensity.standard,
                ),
              ),
            ),
          ],
        )),
      ]),
    );
  }
}
