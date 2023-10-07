import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class TopBannerItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;

  const TopBannerItem({super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: context.width * .4,
        height: context.height * .5,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          GestureDetector(
            onPanUpdate: (DragUpdateDetails d) {
              print(d.delta.dy);
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        imageUrl,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ]));
  }
}
