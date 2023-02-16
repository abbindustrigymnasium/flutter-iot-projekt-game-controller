import 'dart:math';

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
  @override
  void update(dt){
    super.update(dt);
      if(Random().nextInt(80) < 1 ) {
        add(Astriod(Vector2.all(50.0), Vector2(Random().nextDouble()*900,0)));
    }
  }
}

class Player extends SpriteComponent with HasGameRef {
  Vector2 speed = Vector2(0,0);
  Player()
      : super(
          size: Vector2.all(50.0),
        );
  @override
  void update(dt) {
    position += speed * dt;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('download.png');
    position = gameRef.size / 2;
  }

  void setSpeed(Vector2 a) {
    speed = a;
  }
}

class Astriod extends SpriteComponent with HasGameRef {
  Vector2 speed = Vector2(0,100);
  Astriod(Vector2 size, Vector2 startPosition)
      : super(
          size: size,
          position: startPosition
        );
  @override
  void update(dt) {
    position += speed * dt;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('ast.png');
  }

  void setSpeed(Vector2 a) {
    speed = a;
  }
}