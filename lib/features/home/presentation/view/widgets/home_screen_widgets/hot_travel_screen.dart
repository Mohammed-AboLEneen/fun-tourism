import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

class HotTravelScreen extends StatefulWidget {
  final HotTravelModel hotTravelModel;

  const HotTravelScreen({super.key, required this.hotTravelModel});

  @override
  State<HotTravelScreen> createState() => _HotTravelScreenState();
}

class _HotTravelScreenState extends State<HotTravelScreen> {
  bool isOpened = false;

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
                                widget.hotTravelModel.image!,
                                height: context.height * .34,
                                width: context.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: HotTravelScreenInfo(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ExpansionPanelList(
                              animationDuration: const Duration(
                                  milliseconds: 500),
                              expansionCallback: (int panelIndex,
                                  bool isExpanded) {
                                setState(() {
                                  isOpened = !isOpened;
                                });
                              },
                              children: [expansionPanelItem(isOpened)],
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
                                  'Ghardaka',
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
                            Container(
                                width: context.width,
                                height: context.height * .1,
                                decoration: BoxDecoration(
                                  color: Colors.white.withLightness(.93),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Ahmed Osman Mohammed'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: context.height * .1,
                                      width: context.width * .16,
                                      child: const CircleAvatar(
                                        child: FaIcon(FontAwesomeIcons.person),
                                      ),
                                    )
                                  ],
                                )),

                            // make space between TextButton and the last widget in Column
                            if(isOpened)
                              SizedBox(height: context.height * .07,)
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
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(
                                      20)), // Change this value as needed
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.indigo.withLightness(.55),
                          ),
                        ),
                        child: Text(
                          'Join Now',
                          style: GoogleFonts.akayaKanadaka().copyWith(
                              color: Colors.white.withLightness(.8),
                              fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class HotTravelScreenInfo extends StatelessWidget {
  const HotTravelScreenInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .25,
      width: context.width * .9,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Sightseeing Tours',
                style: GoogleFonts.abel().copyWith(
                    fontSize: 14.sp, color: Colors.white.withLightness(.45)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('Super Safari VIP',
                  style: GoogleFonts.abel().copyWith(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              const SizedBox(
                height: 5,
              ),
              Text('300 EGP',
                  style: GoogleFonts.abel().copyWith(
                    fontSize: 18.sp,
                    color: Colors.white.withLightness(.3),
                  )),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('7 hours',
                      style: GoogleFonts.abel().copyWith(
                        fontSize: 15.sp,
                        color: Colors.white.withLightness(.2),
                      )),
                  const Spacer(),
                  Text('Duration',
                      style: GoogleFonts.abel().copyWith(
                        fontSize: 15.sp,
                        color: Colors.white.withLightness(.2),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text('0.0',
                          style: GoogleFonts.abel().copyWith(
                            fontSize: 15.sp,
                            color: Colors.white.withLightness(.2),
                          )),
                      FaIcon(
                        FontAwesomeIcons.solidStar,
                        size: 15.h,
                        color: Colors.yellow.withLightness(.498),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text('Rating',
                      style: GoogleFonts.abel().copyWith(
                        fontSize: 15.sp,
                        color: Colors.white.withLightness(.2),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

ExpansionPanel expansionPanelItem(isOpened) {
  return ExpansionPanel(
    backgroundColor: Colors.white.withLightness(.95),
    headerBuilder: (BuildContext context, bool isExpanded) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Tour Information',
          style: GoogleFonts.aBeeZee().copyWith(fontSize: 20.sp),
        ),
      );
    },
    body: const Padding(
      padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Text(
          'Embark on a breathtaking sunset cruise adventure that will take you on a memorable journey through the open waters of the sea. Step aboard a luxurious yacht and set sail with a small group of fellow adventurers. As you leave the shore behind, feel the gentle sway of the boat and the refreshing sea breeze against your face.'),
    ),
    isExpanded: isOpened,
  );
}
