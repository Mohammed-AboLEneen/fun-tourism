import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/hot_travel/travel_item.dart';

import '../../../../../../../cores/utils/routers.dart';

class TravelsCard extends StatelessWidget {
  final HotTravelModel hotTravelModel;

  const TravelsCard({super.key, required this.hotTravelModel});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutersClass.hotTravelScreen,
            arguments: hotTravelModel);
      },
      child: Stack(
        children: [
          TravelItem(
            hotTravelModel: hotTravelModel,
          ),
          Positioned(
            bottom: 10,
            left: 5,
            child: Container(
              height: h * .09,
              constraints: BoxConstraints(
                maxHeight: h * .11,
              ),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Travel Price: ${hotTravelModel.travelBriefModel?.price}\$',
                        style: TextStyle(fontSize: h * .021),
                      ),
                      Text(
                        'Available Places: ${hotTravelModel.travelBriefModel?.availablePlaces}',
                        style: TextStyle(fontSize: h * .021),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
