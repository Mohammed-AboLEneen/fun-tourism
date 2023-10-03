import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery
        .of(context)
        .size
        .height;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Text(
                    'Enjoy our interesting excursions',
                    style: TextStyle(
                        fontSize: h * .04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(.9)),
                  ),

                  const SizedBox(height: 10,),
                  Opacity(
                      opacity: .7,
                      child: Text(
                        'Lots of endless fun and excitement, join us now.',
                        style: TextStyle(
                            fontSize: h * .035,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(.9)),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
