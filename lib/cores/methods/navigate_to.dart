import 'package:flutter/cupertino.dart';

void navigateToAndRemove({required page, required context}) {
  Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page),
      (route) => false);
}

void navigateTo({required page, required context}) {
  Navigator.of(context).push(
    PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page),
  );
}
