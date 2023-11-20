import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/hot_travel/hot_travel_screen/hot_travel_screen_creator_part.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../cores/methods/expension_panel.dart';
import '../../../custom_textbutton.dart';
import 'hot_travel_screen_info.dart';

class HotTravelScreen extends StatefulWidget {
  final HotTravelModel hotTravelModel;

  const HotTravelScreen({super.key, required this.hotTravelModel});

  @override
  State<HotTravelScreen> createState() => _HotTravelScreenState();
}

class _HotTravelScreenState extends State<HotTravelScreen>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;

  late AnimationController _controller1;
  late Animation<Offset> _animation1;

  @override
  void initState() {
    super.initState();

    initControllersAndAnimations();
    _controller1.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: context.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: context.height * .4,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                          child: Image.memory(
                            widget.hotTravelModel.travelBriefModel?.image ??
                                Uint8List(0),
                            height: context.height * .34,
                            width: context.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        AnimatedBuilder(
                            animation: _animation1,
                            builder: (_, __) {
                              return SlideTransition(
                                position: _animation1,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: HotTravelScreenInfo(
                                    price: widget
                                        .hotTravelModel.travelBriefModel?.price,
                                    time: widget.hotTravelModel.time,
                                    rate: widget.hotTravelModel.rating,
                                  ),
                                ),
                              );
                            }),
                        Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                splashColor: Colors.indigo,
                                icon: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Colors.white.withLightness(.6),
                                )))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ExpansionPanelList(
                          animationDuration: const Duration(milliseconds: 500),
                          expansionCallback: (int panelIndex, bool isExpanded) {
                            setState(() {
                              isOpened = !isOpened;
                            });
                          },
                          children: [
                            expansionPanelItem(
                                isOpened,
                                widget.hotTravelModel.travelBriefModel
                                    ?.description)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Available in',
                          style: GoogleFonts.abel().copyWith(
                            color: Colors.white.withLightness(.5),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo.withLightness(.55),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: const EdgeInsets.only(right: 5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.hotTravelModel.travelBriefModel?.title ??
                                  '-------',
                              style: GoogleFonts.abel().copyWith(
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text(
                            'Creator',
                            style: GoogleFonts.abel().copyWith(
                              color: Colors.white.withLightness(.3),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        HotTravelScreenCreatorPart(
                            creator: widget.hotTravelModel.creator),

                        SizedBox(
                          height: context.height * .08,
                        ),
                        // make space between TextButton and the last widget in Column
                        if (isOpened)
                          SizedBox(
                            height: context.height * .06,
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.width,
                height: context.height * .07,
                child: CustomTextButton(
                  text: 'Join Now',
                  buttonColor: Colors.indigo,
                  topRight: 20,
                  topLeft: 20,
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void initControllersAndAnimations() {
    _controller1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation1 = Tween<Offset>(
      begin: const Offset(0, -.2),
      end: const Offset(0, 0),
    ).animate(_controller1);
  }
}
