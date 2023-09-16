import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_page_menu.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../cores/methods/slider_banner_options.dart';
import '../../../../cores/utils/images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagesClass.homeBgPngImage), fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: const HomeMenu(),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'FunTourism',
                    style: GoogleFonts.actor(),
                  ),
                ),
                backgroundColor: Colors.white.withOpacity(.4),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.bell)),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.magnifyingGlass))
                ],
                pinned: true,
                floating: true,
                snap: true,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                        height: h * .3,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: w,
                              height: h * .3,
                              child: const Card(
                                color: Colors.white,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: w * .7,
                                height: h * .28,
                                child: SvgPicture.asset(
                                  ImagesClass.homeWelcomeSvgImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: h * .27,
                                width: w * .3,
                                child: Text('Have Fun & Enjoy',
                                    style:
                                        GoogleFonts.tajawal(fontSize: 32.sp)),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: CarouselSlider.builder(
                  options: carouselOptions(context, h),
                  itemCount: 5,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return TravelsCards();
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class TravelsCards extends StatelessWidget {
  const TravelsCards({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SizedBox(
      height: h * .32,
      width: w * .8,
      child: Stack(
        children: [
          SizedBox(
            height: h * .3,
            width: w * .8,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage(
                          ImagesClass.welcomePngImage,
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: Colors.indigo.withOpacity(.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Marsa Matroh',
                        style: GoogleFonts.lobster(
                          fontSize: h * .028,
                          color: Colors.white,
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10)),
                          gradient: LinearGradient(colors: [
                            Colors.indigo.withOpacity(.9),
                            Colors.blue
                          ])),
                      width: w * .2,
                      height: h * .07,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: (h * .07) * .2, left: (w * .2) * .3),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                          size: w * .07,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              height: h * .11,
              constraints: BoxConstraints(
                maxHeight: h * .11,
              ),
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Travel Price: 18\$',
                        style: TextStyle(fontSize: h * .021),
                      ),
                      Text(
                        'Available Places: 5',
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

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Define the shape of the clipper path
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * .1, size.height * .2, size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
