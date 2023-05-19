import 'package:flutter/material.dart';
import 'dart:math';

class Dice extends StatefulWidget {
  final void Function(int diceNumber) onDiceRolled;

  const Dice({Key? key, required this.onDiceRolled, required bool isEnabled})
      : super(key: key);

  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  int _diceNumber = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );

    _animationController!.addListener(() {
      setState(() {});
    });

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _diceNumber = Random().nextInt(6) + 1;
        });
        widget.onDiceRolled(_diceNumber); // Call the callback here
      }
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void rollDice() {
    if (_animationController!.isAnimating) return;
    _animationController!.forward(from: 0.0);
  }

  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        rollDice();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isPressed ? const Color(0xFFA51008) : const Color(0xFFF34D49),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        transform: _isPressed
            ? Matrix4.translationValues(0, 2, 0)
            : Matrix4.translationValues(0, -4, 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1F1B24),
                    Color(0xFF352E3D),
                    Color(0xFF352E3D),
                    Color(0xFF1F1B24),
                  ],
                ),
              ),
            ),
            RotationTransition(
              turns: _animation!,
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2D2939),
                      Color(0xFF423D4F),
                      Color(0xFF423D4F),
                      Color(0xFF2D2939),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    _diceNumber.toString(),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: "GameFont",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
