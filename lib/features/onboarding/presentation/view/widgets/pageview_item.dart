import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageViewItem extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;

  const PageViewItem(
      {super.key,
      required this.height,
      required this.width,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: height * .15, right: width * .1, left: width * .1),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CircleAvatar(
              radius: height * .17,
              backgroundColor: Colors.white.withOpacity(.5)),
          AspectRatio(
              aspectRatio: 5 / 4,
              child: SvgPicture.asset(
                imagePath,
                width: width * .9,
                fit: BoxFit.cover,
              ))
        ],
      ),
    );
  }
}
