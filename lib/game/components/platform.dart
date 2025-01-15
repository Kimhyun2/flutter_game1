import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Platform extends PositionComponent {
  Platform({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = const Color(0xFF00FF00),
    );
  }
} 