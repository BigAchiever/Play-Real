import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedBubbles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Center(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  left: -20,
                  top: 20,
                  child: Bubble(
                    delay: 0,
                  ),
                ),
                Positioned(
                  right: -110,
                  top: 60,
                  child: Bubble(
                    delay: 0,
                  ),
                ),
                Positioned(
                  left: 30,
                  bottom: -50,
                  child: Bubble(
                    size: 0.35,
                    delay: 0,
                  ),
                ),
                Positioned(
                  top: 350,
                  right: 80,
                  child: Bubble(
                    size: 0.8,
                    delay: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Bubble extends StatefulWidget {
  final double delay;
  final double size;

  const Bubble({Key? key, required this.delay, this.size = 0.45})
      : super(key: key);

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _animation = Tween<double>(begin: -20, end: 20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(widget.delay, 1, curve: Curves.easeInOut),
      ),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, _animation.value),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.25),
              blurRadius: 25,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 45,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 2,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 80,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 2,
                      spreadRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 10,
              child: BubbleSpan(
                color: Color(0xFF0FB4FF),
                blur: 8,
              ),
            ),
            const Positioned(
              right: 10,
              child: BubbleSpan(
                color: Color(0xFFFF4484),
                blur: 8,
              ),
            ),
            const Positioned(
              top: 10,
              child: BubbleSpan(
                color: Color(0xFFFFEB3B),
                blur: 8,
              ),
            ),
            const Positioned(
              left: 10,
              child: BubbleSpan(
                color: Color(0xFFFF4484),
                blur: 12,
              ),
            ),
            Positioned(
              bottom: 10,
              child: Transform.rotate(
                angle: 330 * (3.14 / 180),
                child: const BubbleSpan(
                  color: Colors.white,
                  blur: 8,
                  transform: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BubbleSpan extends StatelessWidget {
  final Color color;
  final double blur;
  final bool transform;

  const BubbleSpan({
    Key? key,
    required this.color,
    required this.blur,
    this.transform = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: transform
                  ? Transform.rotate(
                      angle: 45 * (3.14 / 180),
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        heightFactor: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
