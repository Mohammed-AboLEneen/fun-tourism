import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class TopBannerItemTextButton extends StatelessWidget {
  final Radius? topRight;
  final Radius? topLeft;
  final Radius? bottomRight;
  final Radius? bottomLeft;
  final void Function()? action;
  final IconData icon;

  const TopBannerItemTextButton(
      {super.key,
      this.topRight,
      this.topLeft,
      this.bottomRight,
      this.bottomLeft,
      this.action,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .12,
      height: context.height * .07,
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: topRight ?? const Radius.circular(20),
                      bottomRight: bottomRight ?? const Radius.circular(20),
                      topLeft: topLeft ?? const Radius.circular(20),
                      bottomLeft: bottomLeft ??
                          const Radius.circular(
                              20))), // Set the desired border radius
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue
                      .withOpacity(0.5); // Set the desired pressed color
                }
                return Colors.indigo.withOpacity(.9); // Set the default color
              },
            ),
          ),
          onPressed: action,
          child: Icon(icon)),
    );
  }
}
