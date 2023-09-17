import 'package:flutter/cupertino.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Define the shape of the clipper path
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * .1, size.height * .2, size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
