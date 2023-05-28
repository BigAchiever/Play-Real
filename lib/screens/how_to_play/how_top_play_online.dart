import 'package:flutter/material.dart';

class howToPlayOnline extends StatelessWidget {
  const howToPlayOnline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
     
        Center(
          child: Text(
            "How to play online",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
