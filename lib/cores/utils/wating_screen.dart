import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  double begin = 0;
  double end = 1;
  int sliderBannerCurrentIndex = 0;
  Color color = Colors.white.withOpacity(.9);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                    height: context.height * .3,
                    width: context.width,
                    child: Card(color: color)),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: context.height * .32,
                  child: ListView.builder(
                    itemBuilder: (context, index) => SizedBox(
                      width: context.width * .8,
                      child: Card(
                        color: color,
                      ),
                    ),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                    height: context.height * .3,
                    width: context.width,
                    child: Card(color: color)),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: context.height * .13,
                ),
              ),
            ],
          ),
        ));
  }
}
