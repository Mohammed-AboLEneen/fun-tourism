import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/hot_travel/hot_travel_screen/hot_travel_screen_creator_part.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../cores/methods/expension_panel.dart';
import '../../../custom_textbutton.dart';
import 'hot_travel_screen_info.dart';

class HotTravelScreen extends StatefulWidget {
  const HotTravelScreen({
    super.key,
  });

  @override
  State<HotTravelScreen> createState() => _HotTravelScreenState();
}

class _HotTravelScreenState extends State<HotTravelScreen>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late HotTravelModel hotTravelModel;

  late AnimationController pageCardController;
  late Animation<Offset> pageCardAnimation;

  @override
  void initState() {
    super.initState();

    initControllersAndAnimations();
    pageCardController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hotTravelModel =
        ModalRoute.of(context)!.settings.arguments as HotTravelModel;
  }

  @override
  void dispose() {
    pageCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        Hero(
                          tag: hotTravelModel.travelBriefModel?.title ?? '5*4',
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                            child: Image.memory(
                              hotTravelModel.travelBriefModel?.image ??
                                  Uint8List(0),
                              height: context.height * .34,
                              width: context.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                            animation: pageCardAnimation,
                            builder: (_, __) {
                              return SlideTransition(
                                position: pageCardAnimation,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: HotTravelScreenInfo(
                                    price:
                                        hotTravelModel.travelBriefModel?.price,
                                    time: hotTravelModel.time,
                                    rate: hotTravelModel.rating,
                                  ),
                                ),
                              );
                            }),
                        Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
                            expansionPanelItem(isOpened,
                                hotTravelModel.travelBriefModel?.description)
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
                              hotTravelModel.travelBriefModel?.title ??
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
                            creator: hotTravelModel.creator),

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
                  buttonColorLightness: .5,
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
    pageCardController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    pageCardAnimation = Tween<Offset>(
      begin: const Offset(0, -.2),
      end: const Offset(0, 0),
    ).animate(pageCardController);
  }
}
