import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/hot_travel/hot_travel_screen/hot_travel_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/hot_travel/travel_item.dart';

class TravelsCard extends StatefulWidget {
  final HotTravelModel hotTravelModel;

  const TravelsCard({super.key, required this.hotTravelModel});

  @override
  State<TravelsCard> createState() => _TravelsCardState();
}

class _TravelsCardState extends State<TravelsCard>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(seconds: 1),
              // Set the desired duration here
              pageBuilder: (context, animation, secondaryAnimation) {
                AnimationController _controller;
                Animation<Offset> _animation;
                _controller = AnimationController(
                  duration: const Duration(milliseconds: 700),
                  vsync: this,
                );
                _animation = Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: const Offset(0, 0),
                ).animate(_controller);
                _controller.forward();
                return SlideTransition(
                  position: _animation,
                  child: const HotTravelScreen(),
                );
              },
              settings: RouteSettings(arguments: widget.hotTravelModel)),
        );
      },
      child: Stack(
        children: [
          TravelItem(
            hotTravelModel: widget.hotTravelModel,
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
                        'Travel Price: ${widget.hotTravelModel.travelBriefModel?.price}\$',
                        style: TextStyle(fontSize: h * .021),
                      ),
                      Text(
                        'Available Places: ${widget.hotTravelModel.travelBriefModel?.availablePlaces}',
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
