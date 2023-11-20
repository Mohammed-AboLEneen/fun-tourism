import 'package:flutter/material.dart';

class TravelsScreenProvider extends ChangeNotifier {
  List<String> imagesUrl = [
    'https://th.bing.com/th/id/OIP.8Y7MPpxCvqYynT9eY7yY3AHaFj?rs=1&pid=ImgDetMain',
    'https://cdn.britannica.com/37/189737-050-FC9A75B3/palace-gardens-Al-Muntazah-Egypt-Alexandria.jpg',
    'https://i.pinimg.com/originals/fc/73/31/fc73318e9c095d6a44fa5aaaab0b7de6.jpg',
    'https://th.bing.com/th/id/R.0ca1dc0c3122b28a78bad59aa51f8cb6?rik=rdFfNal%2b%2b5Zg9g&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.a247363247a1387768f283cae0bd7641?rik=20orvCAkKBDXkA&pid=ImgRaw&r=0',
    'https://i.pinimg.com/originals/a7/0b/da/a70bda5d607926c6fb26a9d385bdb499.jpg',
    'https://1.bp.blogspot.com/-OU_M_0XxJog/ULI4PysErsI/AAAAAAAAWa0/0bAGq4AGCzk/s1600/Egypt+22.JPG',
    'https://www.ytravelblog.com/wp-content/uploads/2012/09/River-Nile-Cairo-Egypt.jpg',
    'https://advice.aqarmap.com.eg/ar/wp-content/uploads/2019/12/%D8%AA%D9%85%D8%AA%D8%B9-%D8%A8%D8%A7%D9%84%D8%AD%D9%8A%D8%A7%D8%A9-%D9%81%D9%8A-%D8%A7%D9%84%D8%B9%D8%A7%D8%B5%D9%85%D8%A9-%D8%A7%D9%84%D8%A5%D8%AF%D8%A7%D8%B1%D9%8A%D8%A9-%D8%A7%D9%84%D8%AC%D8%AF%D9%8A%D8%AF%D8%A9.jpg',
    'https://th.bing.com/th/id/R.c0891649d61c774780e7a005025d590c?rik=ckFa%2bRHz%2fMsOng&riu=http%3a%2f%2fupload.wikimedia.org%2fwikipedia%2fcommons%2f6%2f6a%2fAbu_Simbel%2c_Nefertari_Temple%2c_front%2c_Egypt%2c_Oct_2004.jpg&ehk=BPUPl6AAHfW2cydEhPGvXOXy%2fhG45hIyYczeouhDzsU%3d&risl=&pid=ImgRaw&r=0',
  ];

  int currentIndex = -1;
  int gridCount = 3;
  double radius = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    gridCount = 3;
    radius = 0;
    notifyListeners();
  }

  void putRadiusValue(int index) {
    radius = 30;
    if (gridCount == index) {
      if (gridCount % 2 != 0) {
        gridCount += 1;
      } else {
        gridCount += 3;
      }
      radius = 60;
    }
  }
}
