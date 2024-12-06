import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  const Stars({super.key, required this.numberOfStars, this.iconSize = 18});

  final int numberOfStars;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < numberOfStars; i++)
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(
              Icons.star,
              color: Colors.orangeAccent,
              size: iconSize,
            ),
          ),
      ],
    );
  }
}
