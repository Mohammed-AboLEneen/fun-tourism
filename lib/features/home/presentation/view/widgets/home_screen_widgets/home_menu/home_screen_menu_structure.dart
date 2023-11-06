import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

import 'home_screen_menu_body.dart';

class HomeScreenMenuStructure extends StatelessWidget {
  final double tBeginColor;
  final double tEndColor;
  final double normalizedXPosition;
  final double xPosition;
  final void Function()? onTapBlackBackGround;

  const HomeScreenMenuStructure(
      {super.key,
      required this.tBeginColor,
      required this.tEndColor,
      required this.normalizedXPosition,
      required this.xPosition,
      this.onTapBlackBackGround});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (normalizedXPosition < 1)
          GestureDetector(
            onTap: onTapBlackBackGround,
            child: TweenAnimationBuilder(
                tween: Tween<double>(begin: tBeginColor, end: tEndColor),
                duration: const Duration(milliseconds: 300),
                builder: (_, value, ___) {
                  if (value < 0) {
                    value = 0;
                  }
                  return Container(
                    width: context.width,
                    height: context.height,
                    color: Colors.black.withOpacity(value),
                  );
                }),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          // Set the duration for the animation
          curve: Curves.easeOut,
          // Set the easing function for the animation
          transform: Matrix4.translationValues(xPosition, 0, 0),
          // Use translation instead of Offset for AnimatedContainer
          width: context.width * .7,
          child: const HomeScreenMenu(),
        )
      ],
    );
  }
}
