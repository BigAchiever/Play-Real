import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String text;
  const LoadingScreen({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width / 1.5,
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "GameFont",
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: SpinKitFoldingCube(
              color: Colors.green,
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}
