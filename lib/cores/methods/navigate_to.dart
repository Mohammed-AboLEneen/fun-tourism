import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/features/home/presentation/view/home_page.dart';
import 'package:go_router/go_router.dart';

void navigateTo({required page, required context}) {
  Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page),
      (route) => false);
}
