import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/home_menu/custom_menu_manger.dart';

class MenuLogicProvider extends ChangeNotifier {
  CustomMenuAppManger customMenuAppManger = CustomMenuAppManger();

  void initCustomMenuValues() {
    customMenuAppManger.initMenuValue();
  }

  void openCustomMenu() {
    customMenuAppManger.openMenu();
    notifyListeners();
  }

  void closeCustomMenu(context) {
    customMenuAppManger.closeMenu(context);
    notifyListeners();
  }

  void realTimeUpdatingValues(BuildContext context, DragUpdateDetails tapInfo) {
    customMenuAppManger.realTimeUpdatingValues(context, tapInfo);
    notifyListeners();
  }

  void leaveScreenWhenMenuMoving(BuildContext context) {
    customMenuAppManger.leaveMenuMoving(context);
    notifyListeners();
  }
}
