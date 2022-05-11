import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:tank/components/player.dart';
import 'package:provider/provider.dart';
import 'package:tank/helpers/direction.dart';
import 'package:tank/joypad_provider.dart';

class TankGame extends FlameGame with KeyboardEvents {
  final Player _player = Player();


  @override
  void onAttach() {
    super.onAttach();
    buildContext?.read<JoypadProvider>().addDirectionChangeListener(onDirectionChange);
  }

  @override
  Future<void>? onLoad() async {
    await add(_player);
  }



  void onDirectionChange(Direction direction){
    _player.direction = direction;
  }
}
