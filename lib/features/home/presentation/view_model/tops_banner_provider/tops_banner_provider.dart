import 'package:flutter/cupertino.dart';

class TopsBannerProvider extends ChangeNotifier {
  int currentItem = 0;
  List<String> imagesUrl = [
    'https://th.bing.com/th/id/OIP.tOjEWXEWnWixb4waOSzNdwHaE8?pid=ImgDet&rs=1',
    'https://th.bing.com/th/id/OIP.tOjEWXEWnWixb4waOSzNdwHaE8?pid=ImgDet&rs=1',
    'https://th.bing.com/th/id/OIP.tOjEWXEWnWixb4waOSzNdwHaE8?pid=ImgDet&rs=1',
    'https://th.bing.com/th/id/OIP.tOjEWXEWnWixb4waOSzNdwHaE8?pid=ImgDet&rs=1',
    'https://th.bing.com/th/id/OIP.tOjEWXEWnWixb4waOSzNdwHaE8?pid=ImgDet&rs=1',
  ];
  List<String> titles = [
    'New Park In Cairo',
    'Offer In New City',
    'Go To With Your Friends',
    'Nothing yet',
    'Nothing',
  ];

  void previousTopsBannerItem() {
    if (currentItem - 1 >= 0) {
      currentItem--;
      notifyListeners();
    }
  }

  void nextTopsBannerItem() {
    if (currentItem + 1 <= 4) {
      currentItem++;
      notifyListeners();
    }
  }
}
