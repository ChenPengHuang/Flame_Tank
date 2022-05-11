import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tank/helpers/direction.dart';
import 'package:tank/helpers/joypad.dart';
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
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: GameWidget(game: game),
    );
  }

}
