import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';




class GameI extends FlameGame with KeyboardEvents  {
  late Player player;
  @override
  Future<void> onLoad() async {
    // empty
    player = Player();
    add(SpriteComponent()..sprite = await loadSprite("space.png")..size = size);
    add(player);
    
    
  }

  @override
  void update(dt){
    super.update(dt);
      var pixelRatio = window.devicePixelRatio;
      var logicalScreenSize = window.physicalSize / pixelRatio;
      if(Random().nextInt(80) < 1 ) {
        add(Astriod(Vector2.all(50.0), Vector2(Random().nextDouble()*logicalScreenSize.width,0)));
    }
    if(Random().nextInt(80) < 1 ) {
        add(Lazer(player.position + Vector2(-40, 0)));
    }
  }
}

class Player extends SpriteComponent with HasGameRef {
  Vector2 speed = Vector2(0,0);
  late SpriteAnimation downAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation turnAnimation;

  late SpriteAnimationComponent skepp; 


  Player()
      : super(size: Vector2.all(100.0),);
  @override
  void update(dt) {
    position += speed * dt;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final spriteSheet = SpriteSheet(image: await image.load('flygskepp1.png'), srcSize: Vector2(1104.00,666.67) );

    downAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0, to: 1 );
    upAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0, to: 2 );
    turnAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0, to: 3 );
    skepp = SpriteAnimationComponent()
      ..animation = upAnimation 
      ..position = gameRef.size / 2;
    add(skepp);

  

  

    

    // position = gameRef.size / 2;
  }

  void setSpeed(Vector2 a) {
    speed = a;
  }
}


class Lazer extends SpriteComponent with HasGameRef{
  Vector2 speed = Vector2(0,-100);
  Lazer(Vector2 pos)
      : super(size: Vector2(3,40),
        position: pos);
  @override
  void update(dt) {
    position += speed * dt;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('röd.png');
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
          size: Vector2.all(80.0),
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