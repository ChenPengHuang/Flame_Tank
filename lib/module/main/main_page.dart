import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tank/app_image.dart';
import 'package:tank/app_text.dart';
import 'package:tank/module/main/model/menu_data.dart';
import 'package:tank/module/main/provider/main_provider.dart';
import 'package:tuple/tuple.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(context),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(
              vertical: 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.logo,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 48,
                  ),
                  child: _StartMenu(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _StartMenu extends StatelessWidget {
  const _StartMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MainProvider, Tuple2<List<MenuData>, int>>(
      selector: (context, provider) => Tuple2<List<MenuData>, int>(
        provider.menus,
        provider.selectedIndex,
      ),
      shouldRebuild: (pre, curr) {
        return pre.item2 != curr.item2 || pre.item1 != curr.item1;
      },
      builder: (context, tuple2, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tuple2.item1
              .map<Widget>(
                (e) => _MenuItem(
                  isSelected: e.index == tuple2.item2,
                  text: e.name,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _MenuItem extends StatelessWidget {
  final bool isSelected;
  final String text;

  const _MenuItem({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.yellow : Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
