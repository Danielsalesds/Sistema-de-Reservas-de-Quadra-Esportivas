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
    Color textColor = const Color(0xFF1A1A1A);//F5F5F5
    Color descColor = const Color(0xFF3A3A3A);
    Color baseColor = const Color(0xFF4A90E2);
    Color cardColor2 = const Color(0xFF5A9BD4);
    Color buttonColor = const Color(0xFF2F80ED);

    Color backgroundTela = const Color(0xFFF5F7FA);
    Color uberBlack = const Color(0xFF1C1C1E);
    Color iconeColor = const Color(0xFF1A1A1A);

    
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
        child: Icon(Icons.add, color:iconeColor),
      );
    }
  }