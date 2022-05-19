import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tank/helpers/direction.dart';
import 'dart:math' as math;

class Player extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Player() : super(size: Vector2.all(48), anchor: Anchor.center);

  final double _speed = 100.0;

  Direction _direction = Direction.none;


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
    add(RectangleHitbox(
      size: size,
    ));
    sprite = Sprite(
      await gameRef.images.load('tank/H1U.png'),
      srcSize: Vector2(48, 48),
    );
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
        if (checkPlayerCanMove(direction)) {
          moveUp(delta);
        }
        break;
      case Direction.down:
        if (checkPlayerCanMove(direction)) {
          moveDown(delta);
        }
        break;
      case Direction.left:
        if (checkPlayerCanMove(direction)) {
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (checkPlayerCanMove(direction)) {
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

  Map<PositionComponent, Direction> collidedComponent  = {};

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);


  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    //发生碰撞==Instance of 'ScreenHitbox<FlameGame>'58488012 , lastDirection=Direction.down
    // 发生碰撞==Instance of 'Brick'856267170 , lastDirection=Direction.right
    // 发生碰撞==Instance of 'Brick'96830315 , lastDirection=Direction.right
    // 释放碰撞==Instance of 'ScreenHitbox<FlameGame>'58488012
    // 发生碰撞==Instance of 'Brick'232425333 , lastDirection=Direction.up
    //转向才碰撞，
    switch (lastDirection) {
      case Direction.up:
        collidedComponent.putIfAbsent(other, () => lastDirection);
        break;
      case Direction.down:
        collidedComponent.putIfAbsent(other, () => lastDirection);
        break;
      case Direction.left:
        collidedComponent.putIfAbsent(other, () => lastDirection);
        break;
      case Direction.right:
        collidedComponent.putIfAbsent(other, () => lastDirection);
        break;
      case Direction.none:
        break;
    }
    print('发生碰撞==${other}${other.hashCode} , lastDirection=$lastDirection');
  }


  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    print('释放碰撞==${other}${other.hashCode}');
    collidedComponent.remove(other);
  }



  bool checkPlayerCanMove(Direction direction){
    int len = collidedComponent.entries.length;
    for(int i=0;  i<len;i++){
       if(collidedComponent.values.elementAt(i) == direction){
        return false;
      }
    }
   return true;
  }
}
