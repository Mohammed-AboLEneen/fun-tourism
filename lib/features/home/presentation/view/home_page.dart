import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_page_menu.dart';
import 'package:google_fonts/google_fonts.dart';

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
              image: AssetImage(ImagesClass.homeBgImage), fit: BoxFit.fill),
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
                  background: Container(
                    color: Colors.white,
                  ),
                ),
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
              SliverFillRemaining(
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
                                  ImagesClass.homeWelcomeImage,
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
            ],
          ),
        ));
  }
}
