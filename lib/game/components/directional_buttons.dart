import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../platform_game.dart';

class DirectionalButtons extends PositionComponent with HasGameRef<PlatformGame>, TapCallbacks, DragCallbacks {
  DirectionalButtons() : super(position: Vector2(50, 550), size: Vector2(150, 150));

  static const double buttonSize = 50;
  static const double spacing = 10;
  
  Direction? currentDirection;

  @override
  bool onTapDown(TapDownEvent event) {
    final localPosition = event.localPosition;
    currentDirection = _getDirection(localPosition);
    return currentDirection != null;
  }

  @override
  bool onTapUp(TapUpEvent event) {
    currentDirection = null;
    gameRef.stopPlayer();
    return true;
  }

  @override
  bool onDragStart(DragStartEvent event) {
    final localPosition = event.localPosition;
    currentDirection = _getDirection(localPosition);
    return currentDirection != null;
  }

  @override
  bool onDragUpdate(DragUpdateEvent event) {
    final localPosition = event.localPosition;
    currentDirection = _getDirection(localPosition);
    return currentDirection != null;
  }

  @override
  bool onDragEnd(DragEndEvent event) {
    currentDirection = null;
    gameRef.stopPlayer();
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (currentDirection != null) {
      gameRef.movePlayer(currentDirection!);
    }
  }

  Direction? _getDirection(Vector2 position) {
    if (_isInLeftButton(position)) {
      return Direction.left;
    }
    if (_isInRightButton(position)) {
      return Direction.right;
    }
    if (_isInUpButton(position)) {
      return Direction.up;
    }
    if (_isInDownButton(position)) {
      return Direction.down;
    }
    return null;
  }

  bool _isInLeftButton(Vector2 position) {
    return position.x >= 0 && 
           position.x <= buttonSize && 
           position.y >= buttonSize + spacing && 
           position.y <= 2 * buttonSize + spacing;
  }

  bool _isInRightButton(Vector2 position) {
    return position.x >= 2 * buttonSize && 
           position.x <= 3 * buttonSize && 
           position.y >= buttonSize + spacing && 
           position.y <= 2 * buttonSize + spacing;
  }

  bool _isInUpButton(Vector2 position) {
    return position.x >= buttonSize && 
           position.x <= 2 * buttonSize && 
           position.y >= 0 && 
           position.y <= buttonSize;
  }

  bool _isInDownButton(Vector2 position) {
    return position.x >= buttonSize && 
           position.x <= 2 * buttonSize && 
           position.y >= 2 * buttonSize + 2 * spacing && 
           position.y <= 3 * buttonSize + 2 * spacing;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // 위쪽 버튼
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(buttonSize, 0, buttonSize, buttonSize),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0x88FFFFFF),
    );
    
    // 왼쪽 버튼
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, buttonSize + spacing, buttonSize, buttonSize),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0x88FFFFFF),
    );
    
    // 오른쪽 버튼
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2 * buttonSize, buttonSize + spacing, buttonSize, buttonSize),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0x88FFFFFF),
    );
    
    // 아래쪽 버튼
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(buttonSize, 2 * buttonSize + 2 * spacing, buttonSize, buttonSize),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0x88FFFFFF),
    );

    // 화살표 아이콘들
    _drawArrows(canvas);
  }

  void _drawArrows(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0xFF000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // 위쪽 화살표
    final upArrowPath = Path()
      ..moveTo(1.5 * buttonSize, 10)
      ..lineTo(1.5 * buttonSize, 30)
      ..moveTo(1.5 * buttonSize, 10)
      ..lineTo(1.5 * buttonSize - 10, 20)
      ..moveTo(1.5 * buttonSize, 10)
      ..lineTo(1.5 * buttonSize + 10, 20);

    // 왼쪽 화살표
    final leftArrowPath = Path()
      ..moveTo(10, 1.5 * buttonSize + spacing)
      ..lineTo(30, 1.5 * buttonSize + spacing)
      ..moveTo(10, 1.5 * buttonSize + spacing)
      ..lineTo(20, 1.5 * buttonSize + spacing - 10)
      ..moveTo(10, 1.5 * buttonSize + spacing)
      ..lineTo(20, 1.5 * buttonSize + spacing + 10);

    // 오른쪽 화살표
    final rightArrowPath = Path()
      ..moveTo(2 * buttonSize + 20, 1.5 * buttonSize + spacing)
      ..lineTo(2 * buttonSize + 40, 1.5 * buttonSize + spacing)
      ..moveTo(2 * buttonSize + 40, 1.5 * buttonSize + spacing)
      ..lineTo(2 * buttonSize + 30, 1.5 * buttonSize + spacing - 10)
      ..moveTo(2 * buttonSize + 40, 1.5 * buttonSize + spacing)
      ..lineTo(2 * buttonSize + 30, 1.5 * buttonSize + spacing + 10);

    // 아래쪽 화살표
    final downArrowPath = Path()
      ..moveTo(1.5 * buttonSize, 2 * buttonSize + 2 * spacing + 40)
      ..lineTo(1.5 * buttonSize, 2 * buttonSize + 2 * spacing + 20)
      ..moveTo(1.5 * buttonSize, 2 * buttonSize + 2 * spacing + 40)
      ..lineTo(1.5 * buttonSize - 10, 2 * buttonSize + 2 * spacing + 30)
      ..moveTo(1.5 * buttonSize, 2 * buttonSize + 2 * spacing + 40)
      ..lineTo(1.5 * buttonSize + 10, 2 * buttonSize + 2 * spacing + 30);

    canvas.drawPath(upArrowPath, paint);
    canvas.drawPath(leftArrowPath, paint);
    canvas.drawPath(rightArrowPath, paint);
    canvas.drawPath(downArrowPath, paint);
  }
} 