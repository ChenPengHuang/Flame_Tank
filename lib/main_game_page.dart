import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tank/tank_game.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  final TankGame game = TankGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(98),
      body: Center(
        child: Container(
          color: Colors.black,
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: GameWidget(game: game),
          ),
        ),
      ),
    );
  }
}
