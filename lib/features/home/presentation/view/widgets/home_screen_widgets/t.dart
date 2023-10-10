import 'package:flutter/material.dart';

class LolScreen extends StatefulWidget {
  const LolScreen({super.key});

  @override
  State<LolScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LolScreen> {
  int sliderBannerCurrentIndex = 0;

  @override
  void initState() {
    super.initState();

    print('opend t');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text('lol t'),),
    );
  }
}
