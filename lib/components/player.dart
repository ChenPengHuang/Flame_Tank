import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tank/helpers/direction.dart';
import 'dart:math' as math;

class Player extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Player() : super(size: Vector2.all(39), anchor: Anchor.center);

  final double _speed = 100.0;

  Direction _direction = Direction.none;

  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;

  set direction(Direction direction) {
    _direction = direction;
    if (_direction != Direction.none) {
      lastDirection = direction;
    }
    _turnOn();
  }

  Direction get direction => _direction;
  Direction lastDirection = Direction.up;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox(size: size));
    sprite = Sprite(
      await gameRef.images.load('tank/H1U.png'),
    );
    position = Vector2(gameRef.size.x / 2 - 50, gameRef.size.y - size.y / 2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _movePlayer(dt);
  }

  void _turnOn() {
    switch (direction) {
      case Direction.up:
        angle = 0;
        break;
      case Direction.down:
        angle = math.pi;
        break;
      case Direction.left:
        angle = math.pi * 3 / 2;
        break;
      case Direction.right:
        angle = math.pi / 2;
        break;
      case Direction.none:
        break;
    }
  }

  void _movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          moveUp(delta);
        }
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          moveDown(delta);
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          moveRight(delta);
        }
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
    if (!_hasCollided) {
      _hasCollided = true;
      _collisionDirection = direction;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    _hasCollided = false;
  }

  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }
}
