import 'package:flutter/material.dart';

class Fire extends StatelessWidget {

  final VoidCallback? onFire;
  const Fire({Key? key, this.onFire,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFire,
      child: SizedBox(
        height: 60,
        width: 60,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x88ffffff),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
