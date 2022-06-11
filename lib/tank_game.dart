import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:tank/boundaries.dart';
import 'package:tank/components/brick.dart';
import 'package:tank/components/bullet.dart';
import 'package:tank/components/fortress.dart';
import 'package:tank/components/player.dart';
import 'package:provider/provider.dart';
import 'package:tank/helpers/direction.dart';
import 'package:tank/joypad_provider.dart';

class TankGame extends Forge2DGame {
  double unitSize = 48;
  late Player _player;
  late Fortress _fortress;

  TankGame() : super(gravity: Vector2(0, 0), zoom: 1);

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    unitSize = canvasSize.x / 13;
  }

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
    _addFortress();
    var playerSize = Vector2(unitSize, unitSize);
    _player = Player(
      Vector2(
        ((size.x / 2 - _fortress.size.x/2) - unitSize/2 - playerSize.x / 2),
        size.y - playerSize.y / 2,
      ),
    );
    await add(_player);
  }

  Future<void> _addFortress() async {
    Vector2 fortressSize = Vector2(unitSize, unitSize);
    Vector2 fortressPosition = Vector2(size.x / 2, size.y - fortressSize.y / 2);
    _fortress = Fortress(fortressPosition, size: fortressSize);
    await add(_fortress);
    double brickSize = unitSize/2;
    add(
      Brick(
        Vector2(
          fortressPosition.x - brickSize / 2 - fortressSize.x / 2,
          size.y - brickSize / 2,
        ),
        size: Vector2(brickSize, brickSize),
      ),
    );
    add(
      Brick(
        Vector2(
          fortressPosition.x - brickSize / 2 - fortressSize.x / 2,
          size.y - brickSize * 1.5,
        ),
        size: Vector2(brickSize, brickSize),
      ),
    );
    add(
      Brick(
        Vector2(
          fortressPosition.x - brickSize / 2 - fortressSize.x / 2,
          size.y - brickSize * 2.5,
        ),
        size: Vector2(brickSize, brickSize),
      ),
    );
    add(
      Brick(
        Vector2(fortressPosition.x- brickSize / 2, size.y - brickSize * 2.5),
        size: Vector2(brickSize, brickSize),
      ),
    );
    add(
      Brick(
        Vector2(fortressPosition.x + brickSize / 2, size.y - brickSize * 2.5),
        size: Vector2(brickSize, brickSize),
      ),
    );
    add(
      Brick(
        Vector2(fortressPosition.x + brickSize * 1.5, size.y - brickSize * 2.5),
        size: Vector2(brickSize, brickSize),
      ),
    );

    add(
      Brick(
        Vector2(fortressPosition.x + brickSize * 1.5, size.y - brickSize * 1.5),
        size: Vector2(brickSize, brickSize),
      ),
    );
    add(
      Brick(
        Vector2(fortressPosition.x + brickSize * 1.5, size.y - brickSize/2),
        size: Vector2(brickSize, brickSize),
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
        bullet.position = _player.body.position ;
        break;
      case Direction.down:
        bullet.position = _player.body.position ;
        break;
      case Direction.left:
        bullet.position = _player.body.position ;
        break;
      case Direction.right:
        bullet.position = _player.body.position ;
        break;
      case Direction.none:
        break;
    }
    add(bullet);
  }
}
