import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'components/platform.dart';
import 'components/player.dart';
import 'components/directional_buttons.dart';
import 'components/jump_button.dart';

enum Direction { up, down, left, right }

class PlatformGame extends FlameGame with KeyboardEvents {
  late Player player;
  static const double playerSpeed = 3.0;
  static const double jumpForce = 10.0;
  static const double gravity = 0.5;
  bool isJumping = false;
  double verticalVelocity = 0;

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  @override
  Future<void> onLoad() async {
    player = Player();
    add(player);
    add(DirectionalButtons());
    add(JumpButton());
  }

  void movePlayer(Direction direction) {
    switch (direction) {
      case Direction.left:
        player.position.x -= playerSpeed;
        if (player.isFacingRight) {
          player.flipHorizontally();
          player.isFacingRight = false;
        }
        if (!player.isMoving) {
          player.animation = player.runAnimation;
          
          player.isMoving = true;
        }
        break;
      case Direction.right:
        player.position.x += playerSpeed;
        if (!player.isFacingRight) {
          player.flipHorizontally();
          player.isFacingRight = true;
        }
        if (!player.isMoving) {
          player.animation = player.runAnimation;
          
          player.isMoving = true;
        }
        break;
      case Direction.up:
        player.position.y -= playerSpeed;
        if (!player.isMoving) {
          player.animation = player.runAnimation;
          player.animation = player.idleAnimation;
          player.isMoving = true;
        }
        break;
      case Direction.down:
        player.position.y += playerSpeed;
        if (!player.isMoving) {
          player.animation = player.runAnimation;
          player.animation = player.idleAnimation;
          player.isMoving = true;
        }
        break;
    }
  }

  void stopPlayer() {
    if (player.isMoving) {
      player.animation = player.idleAnimation;
      player.animation = player.idleAnimation;
      player.isMoving = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isJumping) {
      player.position.y += verticalVelocity;
      verticalVelocity += gravity;
      
      // 바닥에 도달하면 점프 상태 종료
      if (player.position.y >= 300) { // 초기 y 위치
        player.position.y = 300;
        isJumping = false;
        verticalVelocity = 0;
        player.animation = player.idleAnimation;
      }
    }
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      verticalVelocity = -jumpForce;
      player.animation = player.runAnimation;
    }
  }
}