import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../platform_game.dart';

class JumpButton extends PositionComponent with TapCallbacks, HasGameRef<PlatformGame> {
  final Paint _paint;
  bool _isPressed = false;

  JumpButton() 
    : _paint = Paint()..color = const Color(0x88FFFFFF),
      super(
        position: Vector2(650, 450),
        size: Vector2(80, 80),
        anchor: Anchor.center,
      );

  @override
  bool onTapDown(TapDownEvent event) {
    _isPressed = true;
    _paint.color = const Color(0x44FFFFFF);
    gameRef.jump();
    return true;
  }

  @override
  bool onTapUp(TapUpEvent event) {
    _isPressed = false;
    _paint.color = const Color(0x88FFFFFF);
    return true;
  }

  @override
  bool onTapCancel(TapCancelEvent event) {
    _isPressed = false;
    _paint.color = const Color(0x88FFFFFF);
    return true;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      _paint,
    );

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'JUMP',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.x - textPainter.width) / 2,
        (size.y - textPainter.height) / 2,
      ),
    );
  }
} 