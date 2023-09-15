
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../view_model/menu_provider/menu_provider.dart';
import 'item_menu.dart';

class MenuListView extends StatelessWidget {


  final List<String> titles;
  final List<IconData> icons;
  final double? h;


  const MenuListView({super.key, required this.titles, required this.icons, this.h, });

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (_,model,__){

        return SizedBox(

          height: h,
          child: ListView.builder(
            itemBuilder: (context, index) => GestureDetector(

              behavior: HitTestBehavior.translucent,
              onTap: (){

                model.changeSelectedIndex(titles[index]);
              },
              child: MenuItem(
                text: titles[index],
                icon: icons[index],
                isSelected: model.selectedItemTitle == titles[index]? true : false,
              ),
            ),
            itemCount: titles.length,
          ),
        );
      },
    );
  }
}