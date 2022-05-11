import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tank/helpers/direction.dart';
import 'dart:math' as math;

class Fortress extends SpriteComponent with HasGameRef, CollisionCallbacks {

  Fortress() : super(size: Vector2(48, 48), anchor: Anchor.center);

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    add(RectangleHitbox(size: size));
    sprite = Sprite(
      await gameRef.images.load('flag.png'),
    );
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - size.y / 2);
  }
}