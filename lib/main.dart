import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game/platform_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 가로 모드 고정
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  runApp(
    const GameApp(),
  );
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            // 배경 색상 또는 이미지를 여기에 추가
            color: Colors.black87,
            // 이미지를 사용하려면 아래 코드를 사용
            // image: DecorationImage(
            //   image: AssetImage('assets/images/background.png'),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: GameWidget(
            game: PlatformGame(),
          ),
        ),
      ),
    );
  }
}
