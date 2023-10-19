import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class DragContainer extends StatefulWidget {
  const DragContainer({super.key});

  @override
  DragContainerState createState() => DragContainerState();
}

class DragContainerState extends State<DragContainer>
    with SingleTickerProviderStateMixin {
  late double xPosition;
  late double normalizedXPosition;
  late final window;
  late final Size size;

  double tweenBeginScale = 0;
  double tweenEndScale = 0;

  double tweenBeginColor = 1;
  double tweenEndColor = 1;

  @override
  void initState() {
    super.initState();
    window = WidgetsBinding.instance.platformDispatcher.views.first;
    size = window.physicalSize / window.devicePixelRatio;
    xPosition = -1.0 *
        (size.width) *
        .8; // set xPosition to negative of container's width
    normalizedXPosition = xPosition / (size.width * .8); // normalize
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onPanUpdate: (tapInfo) {
        setState(() {
          if (xPosition + tapInfo.delta.dx <= 1 &&
              (xPosition + tapInfo.delta.dx) > -(context.width * .8)) {
            xPosition += tapInfo.delta.dx * 1.3;

            tweenBeginScale = normalizedXPosition;
            tweenBeginColor = normalizedXPosition;
            normalizedXPosition =
                -(xPosition / (context.width * .8)); // normalize xPosition
            tweenEndColor = normalizedXPosition;
            tweenEndScale = normalizedXPosition;
          }
          // Check if newXPosition is within screen bounds
        });
      },
      onPanEnd: (de) {
        if (normalizedXPosition > .5) {
          xPosition = -1.0 * (context.width) * .8;
          normalizedXPosition = 1;
          tweenBeginScale = 1;
          tweenBeginColor = 1;
          tweenEndColor = normalizedXPosition;
        } else {
          xPosition = 0;
          normalizedXPosition = 0;
          tweenBeginScale = normalizedXPosition;
          tweenBeginColor = normalizedXPosition;
          tweenEndScale = 0;
          tweenEndColor = 0;
        }

        setState(() {});
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              TweenAnimationBuilder(
                  tween:
                      Tween<double>(begin: tweenBeginScale, end: tweenEndScale),
                  duration: const Duration(milliseconds: 150),
                  builder: (_, value, ___) {
                    return Transform.scale(
                      scale: 1 - (1 - value) * .1,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                              Center(
                                child: Text('content'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              Stack(
                children: [
                  TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: tweenBeginColor, end: tweenEndColor),
                      duration: const Duration(milliseconds: 300),
                      builder: (_, value, ___) {
                        if (value < .5) {
                          value = .5;
                        }
                        return Container(
                          width: context.width,
                          height: context.height,
                          color: Colors.black.withOpacity((1 - value)),
                        );
                      }),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    // Set the duration for the animation
                    curve: Curves.easeOut,
                    // Set the easing function for the animation
                    transform: Matrix4.translationValues(xPosition, 0, 0),
                    // Use translation instead of Offset for AnimatedContainer
                    width: context.width * .8,
                    color: Colors.blue,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
