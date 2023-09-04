import 'package:flutter/material.dart';

class OnBoardingCustomIcon extends StatelessWidget {
  const OnBoardingCustomIcon(
      {super.key,
      required this.widget,
      this.tap,
      required this.height,
      required this.width,
      this.color});

  final void Function()? tap;
  final Widget widget;
  final double height;
  final double width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(70),
      color: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: tap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  color ?? Colors.white,
                ], // Define your gradient colors

                stops: const [
                  0,
                  .9,
                ]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: width,
              height: height,
              child: widget,
            ),
          ),
        ),
      ),
    );
  }
}
