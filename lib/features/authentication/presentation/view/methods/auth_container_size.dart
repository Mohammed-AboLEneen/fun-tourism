double getPageViewContainerSize({required double h, required double pageView}) {
  if (pageView <= 1) {
    if (h < 600) {
      return (h * .46) + (pageView * (h * .32));
    } else {
      return (h * .4) + (pageView * (h * .24));
    }
  } else {
    if (h < 600) {
      return ((h * .46) + (h * .32)) + ((pageView - 1) * h * .08);
    } else {
      return ((h * .4) + ((h * .24))) + (pageView - 1) * h * .08;
    }
  }
}
