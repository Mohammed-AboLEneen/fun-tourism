import 'package:flutter/cupertino.dart';

class RecentNewsBannerTitleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * .6);

    path.quadraticBezierTo(
        size.width * .1, 0, size.width * .5, size.height * .4);
    path.quadraticBezierTo(
        size.width * .8, size.height * .6, size.width, size.height * .5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
