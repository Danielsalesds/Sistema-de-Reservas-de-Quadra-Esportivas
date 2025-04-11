import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: const Icon(Icons.add, color: Color(0xFF6B9AC4)),
      shape: const CircleBorder(),
      elevation: 6,
    );
  }
}
