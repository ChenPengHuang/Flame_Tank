import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:tank/boundaries.dart';
import 'package:tank/components/brick.dart';
import 'package:tank/components/bullet.dart';
import 'package:tank/components/fortress.dart';
import 'package:tank/components/player.dart';
import 'package:provider/provider.dart';
import 'package:tank/helpers/direction.dart';
import 'package:tank/joypad_provider.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart' show ObjectGroup, TiledObject;

class TankGame extends Forge2DGame {
  final double boxSize = 48;
  late Player _player;
  late Fortress _fortress;

  TankGame() : super(gravity: Vector2(0, 10.0), zoom: 1);

  @override
  void onAttach() {
    super.onAttach();
    JoypadProvider? joypadProvider = buildContext?.read<JoypadProvider>();
    joypadProvider?.addDirectionChangeListener(onDirectionChange);
    joypadProvider?.addOnFireListener(onFire);
  }

  @override
  Future<void>? onLoad() async {
    addAll(createBoundaries(this));
    await add(ScreenHitbox());
    _addFortress();
    var playerSize = Vector2(48, 48);
    _player = Player(
      Vector2(
        (size.x - _fortress.size.x) / 2 - 24 - playerSize.x / 2,
        size.y - playerSize.y / 2,
      ),
    );
    await add(_player);
  }

  Future<void> _addFortress() async {
    Vector2 fortressSize = Vector2(48.0, 48.0);
    Vector2 fortressPosition = Vector2((size.x  - fortressSize.x) / 2, size.y - fortressSize.y);
    _fortress = Fortress(fortressPosition, size: fortressSize);
    await add(_fortress);
    double brickSize = 24;
    add(
      Brick(
        position: Vector2(fortressSize.x - brickSize, size.y - brickSize),
      ),
    );
    add(
      Brick(
        position: Vector2(fortressSize.x - brickSize, size.y - brickSize * 2),
      ),
    );
    add(
      Brick(
        position: Vector2(fortressSize.x - brickSize, size.y - brickSize * 3),
      ),
    );
    add(
      Brick(
        position: Vector2(fortressSize.x, size.y - brickSize * 3),
      ),
    );
    add(
      Brick(
        position: Vector2(fortressSize.x + brickSize, size.y - brickSize * 3),
      ),
    );
    add(
      Brick(
        position: Vector2(fortressSize.x + brickSize * 2, size.y - brickSize * 3),
      ),
    );

    add(
      Brick(
        position: Vector2(fortressSize.x + brickSize * 2, size.y - brickSize * 2),
      ),
    );
    add(
      Brick(
        position: Vector2(fortressSize.x + brickSize * 2, size.y - brickSize),
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
