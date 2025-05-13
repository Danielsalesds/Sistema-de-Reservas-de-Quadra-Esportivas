import 'package:flutter/material.dart';

import '../../theme/AppColors.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Card(
      color: colors.backgroundColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          // color: Color(0xFF4A90E2), // azul
          color: colors.baseColor,
          width: 1.5,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.sports_tennis, color: colors.baseColor, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Bem-vindo ao sistema de gerenciamento de quadras',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: colors.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
