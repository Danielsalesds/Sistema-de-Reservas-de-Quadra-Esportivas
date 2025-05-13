import 'package:flutter/material.dart';

import '../../theme/AppColors.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return FloatingActionButton(
      onPressed: onTap,
      backgroundColor: colors.cardColor,
      shape: const CircleBorder(),
      elevation: 6,
      child: Icon(Icons.person_add, color: colors.textColor),
    );
  }
}
