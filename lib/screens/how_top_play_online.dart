import 'package:flutter/material.dart';
import 'package:play_real/widgets/blur_screen_widget.dart';

import '../background.dart';

class howToPlayOnline extends StatelessWidget {
  const howToPlayOnline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        const AnimatedBubbles(),
        blurScreenWidget(context),
        Center(
          child: Text("How to play online"),
        ),
      ]),
    );
  }
}
