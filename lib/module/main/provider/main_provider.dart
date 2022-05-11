import 'package:flutter/material.dart';
import 'package:tank/app_text.dart';
import 'package:tank/helpers/direction.dart';
import 'package:tank/joypad_provider.dart';
import 'package:tank/main_game_page.dart';
import 'package:tank/module/main/model/menu_data.dart';
import 'package:provider/provider.dart';

class MainProvider with ChangeNotifier {
  final List<MenuData> menus = [
    MenuData(index: 0, name: AppText.startGame),
    MenuData(index: 1, name: AppText.exit),
  ];

  int selectedIndex = 0;

  final BuildContext context;
  JoypadProvider? _joypadProvider;

  MainProvider(this.context) {
    _joypadProvider = context.read<JoypadProvider>();
    _joypadProvider?.addDirectionChangeListener(onDirectionChange);
    _joypadProvider?.addOnFireListener(onFire);
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

  void onDirectionChange(Direction direction) {
    switch (direction) {
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

  void onFire() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainGamePage(),
      ),
    );
  }

  @override
  void dispose() {
    _joypadProvider?.removeDirectionChangeListener(onDirectionChange);
    _joypadProvider?.removeOnFireListener(onFire);
    _joypadProvider = null;
    super.dispose();
  }
}
