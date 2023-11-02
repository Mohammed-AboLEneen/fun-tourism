import 'package:flutter/cupertino.dart';

class MangeCustomMenuApp {
  late double xPosition;
  late double normalizedXPosition;
  late final window;
  late final Size size;

  double tweenBeginScale = 0;
  double tweenEndScale = 0;

  double tweenBeginColor = 0;
  double tweenEndColor = 0;
  late double menuWidth;

  void initMenuValue() {
    window = WidgetsBinding.instance.platformDispatcher.views.first;
    size = window.physicalSize / window.devicePixelRatio;
    menuWidth = size.width * .9;
    xPosition =
        -1.0 * menuWidth; // set xPosition to negative of container's width
    normalizedXPosition = xPosition / (menuWidth); // normalize
  }

  void realTimeUpdatingValues(BuildContext context, DragUpdateDetails tapInfo) {
    if (xPosition + (tapInfo.delta.dx * 2) < 0 &&
        (xPosition + tapInfo.delta.dx) > -(menuWidth)) {
      xPosition += tapInfo.delta.dx * 2;

      updateTweenBeginScaleAndColorValue();

      // normalize xPosition ( make it value from 0 to 1)
      normalizedXPosition = -(xPosition / (menuWidth));
      // make the range from 0 to .05 not from 1 to 0
      updateTweenEndScaleAndColorValue();
    }
  }

  // when user stop touching screen.
  void leaveMenuMoving(BuildContext context) {
    if (normalizedXPosition > .5) {
      xPosition = -1.0 * menuWidth;
      normalizedXPosition = 1;

      updateTweenBeginScaleAndColorValue();
      tweenEndScale = 0;
      tweenEndColor = 0;
    } else {
      xPosition = 0;
      normalizedXPosition = 0;

      updateTweenEndScaleAndColorValue();
      tweenEndScale = .05;
      tweenEndColor = .2;
    }
  }

  // this method called when moving menu to determine the beginning value for scale and black color with menu when it open.
  void updateTweenBeginScaleAndColorValue() {
    tweenBeginScale = .05 - ((normalizedXPosition * .05));
    tweenBeginColor = .2 - ((normalizedXPosition * .2));
  }

  // this method called when moving menu to determine the Ending value for scale and black color with menu when it open.
  void updateTweenEndScaleAndColorValue() {
    tweenEndScale = .05 - ((normalizedXPosition * .05));
    tweenEndColor = .2 - ((normalizedXPosition * .2));
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
    xPosition = -1.0 * menuWidth;
    normalizedXPosition = 1;

    tweenBeginScale = .05 - (normalizedXPosition * .05);
    tweenEndScale = 0;
    tweenBeginColor = .2 - ((normalizedXPosition * .2));
    tweenEndColor = 0;
  }
}
