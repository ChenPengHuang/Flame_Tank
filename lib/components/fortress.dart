import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math' as math;

import 'package:flame_forge2d/flame_forge2d.dart';

class Fortress extends BodyComponent {
  final Vector2 position;
  final Vector2 size;

  Fortress(
    this.position, {
    Vector2? size,
  }) : size = size ?? Vector2(48, 48);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final sprite = await gameRef.loadSprite('flag.png');

    add(
      SpriteComponent(
        sprite: sprite,
        size: size,
        anchor: Anchor.center,
      ),
    );
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
      userData: this, // To be able to determine object in collision
      restitution: 0.8,
      density: 1.0,
      friction: 0.2,
    );

    final bodyDef = BodyDef(
      position: position,
      type: BodyType.static,
    )..userData = this; //开启检测碰撞

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
