import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/menu_provider/menu_provider.dart';
import 'information_card.dart';
import 'menu_listview.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuProvider(),
      child: Consumer<MenuProvider>(
        builder: (_, model, __) {
          return Drawer(
            width: MediaQuery.of(context).size.width * .7,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.white.withOpacity(.7),
                      Colors.indigo.withOpacity(.7)
                    ],
                        stops: const [
                      0,
                      .5
                    ])),
                child: SafeArea(
                  child: Column(
                    children: [
                      const InfoCard(),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Browse',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          )),
                      MenuListView(
                        titles: model.listTitles1,
                        icons: model.listIcons1,
                        h: MediaQuery.of(context).size.height * .43,
                      ),
                      const Align(
                          alignment: Alignment.center,
                          child: Text('History',
                              style: TextStyle(
                                fontSize: 25,
                              ))),
                      MenuListView(
                        titles: model.listTitles2,
                        icons: model.listIcons2,
                        h: MediaQuery.of(context).size.height * .2,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
