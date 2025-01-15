import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../platform_game.dart';

class Player extends SpriteAnimationComponent with HasGameRef<PlatformGame>, KeyboardHandler {
  late SpriteAnimation _runAnimation;
  late SpriteAnimation _idleAnimation;
  bool isFacingRight = true;
  bool isMoving = false;

  Player() : super(size: Vector2(50, 50), position: Vector2(300, 300));

  SpriteAnimation get runAnimation => _runAnimation;
  SpriteAnimation get idleAnimation => _idleAnimation;

  @override
  Future<void> onLoad() async {
    final runSpriteSheet = await gameRef.images.load('images/333.png');
    final idleSpriteSheet = await gameRef.images.load('images/111.png');
    
    _runAnimation = SpriteAnimation.fromFrameData(
      runSpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.1,
        textureSize: Vector2(40, 35),
      ),
    );

    _idleAnimation = SpriteAnimation.fromFrameData(
      idleSpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.1,
        textureSize: Vector2(72, 135),
      ),
    );

    animation = _idleAnimation;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is KeyDownEvent;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      position.x -= 5;
      if (isFacingRight) {
        flipHorizontally();
        isFacingRight = false;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      position.x += 5;
      if (!isFacingRight) {
        flipHorizontally();
        isFacingRight = true;
      }
    }

    return super.onKeyEvent(event, keysPressed);
  }
} 