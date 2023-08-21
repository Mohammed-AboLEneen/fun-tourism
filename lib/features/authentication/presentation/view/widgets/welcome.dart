import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Text(
                        'Enjoy our interesting excursions',
                        style: TextStyle(
                            fontSize: 35.sp, fontWeight: FontWeight.bold),
                      ),
                      Opacity(
                          opacity: .7,
                          child: Text(
                            'Lots of endless fun and excitement, join us now.',
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.w400),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
