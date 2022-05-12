import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tank/components/brick.dart';
import 'package:tank/helpers/direction.dart';
import 'dart:math' as math;

class Bullet extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final double _speed = 100.0;

  final Direction direction;

  Bullet({
    required this.direction,
  }) : super(size: Vector2(8, 10));

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    add(RectangleHitbox(size: size));
    sprite = Sprite(
      await gameRef.images.load('bullet/normal.png'),
    );
    switch (direction) {
      case Direction.up:
        angle = -math.pi / 2;
        break;
      case Direction.down:
        angle = math.pi / 2;
        break;
      case Direction.left:
        angle = math.pi;
        break;
      case Direction.right:
        angle = 0;
        break;
      case Direction.none:
        break;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _movePlayer(dt);
  }

  void _movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        moveUp(delta);
        break;
      case Direction.down:
        moveDown(delta);
        break;
      case Direction.left:
        moveLeft(delta);
        break;
      case Direction.right:
        moveRight(delta);
        break;
      case Direction.none:
        break;
    }
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_speed));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _speed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_speed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _speed, 0));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      gameRef.remove(this);
    } else if (other is Brick) {
      gameRef.remove(this);
    }
  }
}
