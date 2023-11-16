import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../constants.dart';
import '../../../../../../../cores/models/hot_travels_model/hot_travels_model.dart';
import 'hot_travel_card_button_custom_clipper.dart';

class TravelItem extends StatelessWidget {
  final HotTravelModel hotTravelModel;

  const TravelItem({super.key, required this.hotTravelModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .3,
      width: context.width * .8,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              hotTravelModel.travelBriefModel?.image ?? '',
              fit: BoxFit.cover,
              width: context.width,
              height: context.height * .3,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: mainColor.withOpacity(.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  hotTravelModel.travelBriefModel?.title ?? '-----',
                  style: GoogleFonts.lobster(
                    fontSize: context.height * .028,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ClipPath(
              clipper: TravelCardButtonCustomClipper(),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10)),
                    gradient: LinearGradient(
                        colors: [mainColor.withOpacity(.9), Colors.blue],
                        stops: const [0, .95])),
                width: context.width * .2,
                height: context.height * .07,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: (context.height * .07) * .2,
                      left: (context.width * .2) * .3),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: context.width * .07,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
