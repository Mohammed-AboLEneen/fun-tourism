class AuthIconInfo {
  static double getAuthIconBottomHeight(
      {required double h, required double pageValue}) {
    if (h < 600) {
      if (pageValue <= 1) {
        return (h * .03) + pageValue * h * .3;
      } else {
        return ((h * .03) + h * .3) - ((pageValue - 1) * (h * .25));
      }
    } else {
      if (pageValue <= 1) {
        return (h * .03) + pageValue * h * .27;
      } else {
        return ((h * .03) + h * .27) - ((pageValue - 1) * (h * .23));
      }
    }
  }

  static double getAuthIconLeftWidth(
      {required double w, required double pageValue}) {
    if (pageValue <= 1) {
      return w * .02;
    } else {
      return (w * .02) + ((pageValue - 1) * (w * .34));
    }
  }

  static double getAuthIconWidth(
      {required double w, required double pageView}) {
    if (pageView <= 1) {
      return w * .35 - pageView * 50;
    } else {
      return w * .35 - 50;
    }
  }

  static String getAuthIconTitle({required double pageView}) {
    if (pageView <= .5) {
      return 'Get Started >';
    } else if (pageView > .5 && pageView <= 1.6) {
      return 'Sign In';
    } else {
      return 'Sign Up';
    }
  }

  static double getAuthIconTitleOpacity({required double pageView}) {
    if (pageView <= .5 && pageView > 0) {
      return pageView * 1;
    } else if (pageView > .5 && pageView <= 1.6) {
      if (pageView <= 1) {
        return pageView * 1;
      } else {
        print(((pageView) * .3));
        return (1 - ((pageView) * .3));
      }
    } else {
      return 1;
    }
  }
}
