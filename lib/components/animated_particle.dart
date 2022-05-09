import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '/helpers/utils.dart';

class AnimatedParticle extends StatefulWidget {
  final List<double> accelerometerValues;
  const AnimatedParticle({
    Key? key,
    required this.accelerometerValues,
  }) : super(key: key);

  @override
  State<AnimatedParticle> createState() => _AnimatedParticleState();
}

class _AnimatedParticleState extends State<AnimatedParticle>
    with SingleTickerProviderStateMixin {
  late double hScreen, wScreen, size;

  late double initialPos;

  late Timer timer;

  final Color color = HexColor("FFFFFF");

  double step = 0.01;

  @override
  void didChangeDependencies() {
    hScreen = Random().nextDouble() * MediaQuery.of(context).size.height;
    wScreen = Random().nextDouble() * MediaQuery.of(context).size.width;

    size = max(5, Random().nextDouble() * 15);

    initialPos = 0;

    Future.delayed(const Duration(milliseconds: 500), () {
      timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
        if (initialPos < 1) {
          setState(() {
            initialPos += step;
            step *= 0.99;
          });
        }
      });
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final speed = Random().nextDouble() * 10 * 10;

    return AnimatedPositioned(
      top: (hScreen + widget.accelerometerValues[0] * speed) * initialPos,
      right: (wScreen + widget.accelerometerValues[1] * speed) * initialPos,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
      ),
    );
  }
}
