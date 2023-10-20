import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class CustomMenuApp {
  late double xPosition;
  late double normalizedXPosition;
  late final window;
  late final Size size;

  double tweenBeginScale = 0;
  double tweenEndScale = 0;

  double tweenBeginColor = 1;
  double tweenEndColor = 1;

  void initMenuValue() {
    window = WidgetsBinding.instance.platformDispatcher.views.first;
    size = window.physicalSize / window.devicePixelRatio;
    xPosition = -1.0 *
        (size.width) *
        .7; // set xPosition to negative of container's width
    normalizedXPosition = xPosition / (size.width * .7); // normalize
  }

  void realTimeUpdatingValues(BuildContext context, DragUpdateDetails tapInfo) {
    if (xPosition + tapInfo.delta.dx <= 1 &&
        (xPosition + tapInfo.delta.dx) >
            -(context.width * .7)) {
      xPosition += tapInfo.delta.dx * 1.8;
      setBeforeUpdateRealTimeNormalizedValue();

      // normalize xPosition ( make it value from 0 to 1)
      normalizedXPosition =
      -(xPosition / (context.width * .7));
      // make the range from 0 to .05 not from 1 to 0
      setAfterUpdateRealTimeNormalizedValue();
    }
  }

  // this method called when moving menu to determine the beginning value for scale and black color with menu when it open.
  void setBeforeUpdateRealTimeNormalizedValue() {
    tweenBeginScale = .05 - ((normalizedXPosition * .05));
    tweenBeginColor = .2 - ((normalizedXPosition * .2));
  }

  // this method called when moving menu to determine the Ending value for scale and black color with menu when it open.
  void setAfterUpdateRealTimeNormalizedValue() {
    tweenEndScale = .05 - ((normalizedXPosition * .05));
    tweenEndColor = .2 - ((normalizedXPosition * .2));
  }

  // when user stop touching screen.
  void leaveMenuMoving(BuildContext context) {
    if (normalizedXPosition > .5) {
      xPosition = -1.0 * (context.width) * .7;
      normalizedXPosition = 1;

      tweenBeginScale = .05 - (normalizedXPosition * .05);
      tweenEndScale = 0;
      tweenBeginColor = .2 - ((normalizedXPosition * .2));
      tweenEndColor = 0;
    } else {
      xPosition = 0;
      normalizedXPosition = 0;

      tweenBeginScale = .05 - (normalizedXPosition * .05);
      tweenEndScale = .05;
      tweenBeginColor = .2 - ((normalizedXPosition * .2));
      tweenEndColor = .2;
    }
  }

  void openMenu() {
    xPosition = 0;
    xPosition = 0;
    normalizedXPosition = 0;

    tweenBeginScale = .05 - (normalizedXPosition * .05);
    tweenEndScale = .05;
    tweenBeginColor = 0;
    tweenEndColor = .2;
  }

  void closeMenu(BuildContext context) {
    xPosition = -1.0 * (context.width) * .7;
    normalizedXPosition = 1;

    tweenBeginScale = .05 - (normalizedXPosition * .05);
    tweenEndScale = 0;
    tweenBeginColor = .2 - ((normalizedXPosition * .2));
    tweenEndColor = 0;
  }
}
