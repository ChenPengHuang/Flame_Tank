import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';
import 'package:tank/components/bullet.dart';
import 'package:tank/components/player.dart';

class Brick extends BodyComponent {
  final Vector2 position;
  final Vector2 size;

  Brick(
    this.position, {
    Vector2? size,
  }) : size = size ?? Vector2(24, 24);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    renderBody = false;
    final sprite = await gameRef.loadSprite('map/brick.png');

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
      userData: this,
    );

    final bodyDef = BodyDef(
      position: position,
      type: BodyType.static,
      isAwake: false,
    )..userData = this; //开启检测碰撞

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
