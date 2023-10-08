import 'package:flutter/material.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/travel_card_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../cores/utils/images.dart';

class TravelsCard extends StatelessWidget {
  const TravelsCard({super.key});

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
                    clipper: TravelCardButtonCustomClipper(),
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
