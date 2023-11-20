import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/menu_ui_provider/menu_ui_provider.dart';
import 'home_menu_item.dart';

class MenuListView extends StatelessWidget {
  final List<String> titles;
  final List<IconData> icons;
  final double? h;
  final List<void Function()?> actions;

  const MenuListView({
    super.key,
    required this.titles,
    required this.icons,
    this.h,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuUIProvider>(
      builder: (_, model, __) {
        return SizedBox(
          height: h,
          child: ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                model.changeSelectedIndex(titles[index]);
                actions[index]!();
              },
              child: MenuItem(
                text: titles[index],
                icon: icons[index],
                isSelected:
                    model.selectedItemTitle == titles[index] ? true : false,
              ),
            ),
            itemCount: titles.length,
          ),
        );
      },
    );
  }
}
