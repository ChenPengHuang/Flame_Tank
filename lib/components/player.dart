import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:tank/helpers/direction.dart';
import 'dart:math' as math;

class Player extends BodyComponent {
  final double _speed = 100.0;

  final Vector2 position;
  final Vector2 size;

  Player(
    this.position, {
    Vector2? size,
  }) : size = size ?? Vector2(48, 48);

  Direction _direction = Direction.none;

  set direction(Direction direction) {
    _direction = direction;
    if (_direction != Direction.none) {
      lastDirection = direction;
    }
    _turnOn();
  }

  Direction get direction => _direction;
  Direction lastDirection = Direction.none;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    renderBody = false;
    final sprite = await gameRef.loadSprite('tank/H1U.png');
    add(
      SpriteComponent(
        sprite: sprite,
        size: size,
        anchor: Anchor.center,
      ),
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
        body.setTransform(body.position, 0);
        break;
      case Direction.down:
        body.setTransform(body.position, math.pi);
        break;
      case Direction.left:
        body.setTransform(body.position, math.pi * 3 / 2);
        break;
      case Direction.right:
        body.setTransform(body.position, math.pi / 2);
        break;
      case Direction.none:
        break;
    }
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
    body.setTransform(body.position + Vector2(0, delta * -_speed), body.angle);
  }

  void moveDown(double delta) {
    body.setTransform(body.position + Vector2(0, delta * _speed), body.angle);
  }

  void moveLeft(double delta) {
    body.setTransform(body.position + Vector2(delta * -_speed, 0), body.angle);
  }

  void moveRight(double delta) {
    body.setTransform(body.position + Vector2(delta * _speed, 0), body.angle);
  }

  @override
  Body createBody() {
    final shape = PolygonShape();

    final vertices = [
      Vector2(-size.x / 2, size.y / 2),
      Vector2(size.x / 2, size.y / 2),
      Vector2(size.x / 2, -size.y / 2),
      Vector2(-size.x / 2, -size.y / 2),
    ];
    shape.set(vertices);

    final fixtureDef = FixtureDef(
      shape,
      userData: this,
    );

    final bodyDef = BodyDef(
      position: position,
      type: BodyType.dynamic,
    )..userData = this; //开启检测碰撞

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
