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

  void setBeforeUpdateRealTimeNormalizedValue() {
    tweenBeginScale = .05 - ((normalizedXPosition * .05));
    tweenBeginColor = .2 - ((normalizedXPosition * .2));
  }

  void setAfterUpdateRealTimeNormalizedValue() {
    tweenEndScale = .05 - ((normalizedXPosition * .05));
    tweenEndColor = .2 - ((normalizedXPosition * .2));
  }

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
