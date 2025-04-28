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
      return FloatingActionButton(
        heroTag: null,
        onPressed: onPressed,
        elevation: 6,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: ShapeBorder.lerp(
          const CircleBorder(),
          const StadiumBorder(),
          0.5,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      );
    }
  }