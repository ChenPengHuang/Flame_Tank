import 'package:flutter/material.dart';
import 'package:tank/app_text.dart';
import 'package:tank/helpers/direction.dart';
import 'package:tank/joypad_provider.dart';
import 'package:tank/module/main/model/menu_data.dart';
import 'package:provider/provider.dart';

class MainProvider with ChangeNotifier {
  final List<MenuData> menus = [
    MenuData(index: 0, name: AppText.startGame),
    MenuData(index: 1, name: AppText.exit),
  ];

  int selectedIndex = 0;

  final BuildContext context;


  MainProvider(this.context){
    context.read<JoypadProvider>().setDirectionChangeListener(onDirectionChange);
  }

  void changeSelectedMenuItem(Direction direction) {
    if (selectedIndex != menus.length - 1 && direction == Direction.down) {
      selectedIndex++;
      notifyListeners();
    } else if (selectedIndex != 0 && direction == Direction.up) {
      selectedIndex--;
      notifyListeners();
    }

  }

  void onDirectionChange(Direction direction){
    switch(direction){
      case Direction.up:
        changeSelectedMenuItem(direction);
        break;
      case Direction.down:
        changeSelectedMenuItem(direction);
        break;
      case Direction.left:
        break;
      case Direction.right:
        break;
      case Direction.none:
        break;
    }
  }
}
