import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class GameI extends FlameGame with KeyboardEvents {
  @override
  Future<void> onLoad() async {
    // empty
    final Player player = Player();
    add(player);
  }
}

class Player extends SpriteComponent with HasGameRef {
  Vector2 speed = Vector2.all(0);
  Player()
      : super(
          size: Vector2.all(50.0),
        );
  @override
  void update(dt) {
    position += speed;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('github-mark.png');
    position = gameRef.size / 2;
  }

  void setSpeed(Vector2 a) {
    speed = a;
  }
}
