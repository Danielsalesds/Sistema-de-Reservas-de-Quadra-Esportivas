import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget{
  final VoidCallback onPressed;
  final String? heroTag;

  const CustomFAB({
    Key? key,
    required this.onPressed,
    this.heroTag,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color textColor = const Color(0xFFFFFAFA);//F5F5F5
    Color textColor2 = const Color(0xFF333333);
    Color baseColor = const Color(0xFF4A90E2);
    Color cardColor2 = const Color(0xFF5A9BD4);
    Color buttonColor = const Color(0xFF2F80ED);
      return FloatingActionButton(
        heroTag: null,
        onPressed: onPressed,
        elevation: 6,
        backgroundColor: buttonColor,
        shape: ShapeBorder.lerp(
          const CircleBorder(),
          const StadiumBorder(),
          0.5,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      );
    }
  }