import 'package:flutter/cupertino.dart';

class TopsBannerProvider extends ChangeNotifier {
  int currentItem = 0;

  void previousTopsBannerItem() {
    if (currentItem - 1 >= 0) {
      currentItem--;
    } else {
      currentItem = 3;
    }
    notifyListeners();
  }

  void nextTopsBannerItem() {
    if (currentItem + 1 <= 3) {
      currentItem++;
    } else {
      currentItem = 0;
    }
    notifyListeners();
  }
}
