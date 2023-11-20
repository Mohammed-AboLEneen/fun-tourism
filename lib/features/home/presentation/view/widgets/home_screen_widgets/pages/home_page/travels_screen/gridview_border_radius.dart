import 'package:flutter/material.dart';

BorderRadius customBorderRadius(double radius,
        {double? topL, double? bottomR, double? bottomL}) =>
    BorderRadius.only(
        topRight: Radius.circular(radius),
        topLeft: Radius.circular(topL ?? 10),
        bottomLeft: Radius.circular(bottomR ?? 10),
        bottomRight: Radius.circular(bottomL ?? 10));
