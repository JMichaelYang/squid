import 'package:flutter/material.dart';

Widget squidBackground() {
  return Hero(
    tag: 'SquidBackground',
    transitionOnUserGestures: true,
    child: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgrounds/water_background.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
