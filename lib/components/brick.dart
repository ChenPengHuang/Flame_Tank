import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tank/components/bullet.dart';

class Brick extends SpriteComponent with HasGameRef, CollisionCallbacks {

  Brick({
    required Vector2 position,
  }) : super(size: Vector2(24, 24), position: position);

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    add(RectangleHitbox(size: size));
    sprite = Sprite(
      await gameRef.images.load('map/brick.png'),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is Bullet){
      gameRef.remove(this);
    }
  }
}
