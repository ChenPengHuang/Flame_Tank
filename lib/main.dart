import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tank/helpers/fire.dart';
import 'package:tank/helpers/joypad.dart';
import 'package:tank/joypad_provider.dart';
import 'package:tank/module/main/main_page.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<JoypadProvider>(create: (_) => JoypadProvider()),
      ],
      child: MaterialApp(
        title: 'Tank',
        theme: ThemeData(
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
        ),
        builder: (context, child) {
          return Stack(
            children: [
              child ?? const SizedBox.shrink(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Joypad(
                    onDirectionChanged:
                        context.read<JoypadProvider>().onDirectionChange,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Fire(
                    onFire: context.read<JoypadProvider>().onFire,
                  ),
                ),
              ),
            ],
          );
        },
        home: const MainPage(),
      ),
    );
  }
}
