import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tank/components/brick.dart';
import 'package:tank/components/bullet.dart';
import 'package:tank/components/fortress.dart';
import 'package:tank/components/player.dart';
import 'package:provider/provider.dart';
import 'package:tank/helpers/direction.dart';
import 'package:tank/joypad_provider.dart';

class TankGame extends FlameGame with HasCollisionDetection {
  final double boxSize = 48;
  final Player _player = Player();
  final Fortress _fortress = Fortress();

  @override
  void onAttach() {
    super.onAttach();
    JoypadProvider? joypadProvider = buildContext?.read<JoypadProvider>();
    joypadProvider?.addDirectionChangeListener(onDirectionChange);
    joypadProvider?.addOnFireListener(onFire);
  }

  @override
  Future<void>? onLoad() async {
    await add(ScreenHitbox());
    _addFortress();
    _player.position = Vector2(
      (size.x  - _fortress.size.x) / 2 - 24 - _player.size.x / 2,
      size.y - _player.size.y / 2,
    );
    await add(_player);
  }

  Future<void> _addFortress() async {
    await add(_fortress);
    double brickSize = 24;
    add(
      Brick(
        position: Vector2(_fortress.x - brickSize, size.y - brickSize),
      ),
    );
    add(
      Brick(
        position: Vector2(_fortress.x - brickSize, size.y - brickSize * 2),
      ),
    );
    add(
      Brick(
        position: Vector2(_fortress.x - brickSize, size.y - brickSize * 3),
      ),
    );
    add(
      Brick(
        position: Vector2(_fortress.x, size.y - brickSize * 3),
      ),
    );
    add(
      Brick(
        position: Vector2(_fortress.x + brickSize, size.y - brickSize * 3),
      ),
    );
    add(
      Brick(
        position: Vector2(_fortress.x + brickSize * 2, size.y - brickSize * 3),
      ),
    );

    add(
      Brick(
        position: Vector2(_fortress.x + brickSize * 2, size.y - brickSize * 2),
      ),
    );
    add(
      Brick(
        position: Vector2(_fortress.x + brickSize * 2, size.y - brickSize),
      ),
    );
  }

  void onDirectionChange(Direction direction) {
    _player.direction = direction;
  }

  void onFire() {
    Bullet bullet = Bullet(direction: _player.lastDirection);
    switch (_player.lastDirection) {
      case Direction.up:
        bullet.position = _player.position - Vector2(0, _player.size.y / 2);
        break;
      case Direction.down:
        bullet.position = _player.position + Vector2(0, _player.size.y / 2);
        break;
      case Direction.left:
        bullet.position = _player.position - Vector2(_player.size.y / 2, 0);
        break;
      case Direction.right:
        bullet.position = _player.position + Vector2(_player.size.y / 2, 0);
        break;
      case Direction.none:
        break;
    }
    add(bullet);
  }
}
