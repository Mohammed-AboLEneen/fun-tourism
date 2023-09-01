import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.widget, this.tap});

  final void Function()? tap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(0),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: tap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: widget,
        ),
      ),
    );
  }
}
