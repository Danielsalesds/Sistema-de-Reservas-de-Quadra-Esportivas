import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({super.key, required this.onTap});

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
      onPressed: onTap,
      backgroundColor: buttonColor,
      child: const Icon(Icons.person_add, color: Color(0xFFEFF0F1)),
      shape: const CircleBorder(),
      elevation: 6,
    );
  }
}
