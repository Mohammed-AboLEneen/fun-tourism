import 'package:flutter/cupertino.dart';

extension Dimensions on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;
}
