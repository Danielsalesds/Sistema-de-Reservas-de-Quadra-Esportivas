import 'package:flutter/material.dart';
import '../../theme/AppColors.dart';

class CardAdmin extends StatefulWidget {
  final String titulo;
  final String text1;
  final IconData icon;
  final VoidCallback? onTap;

  const CardAdmin({
    super.key,
    required this.titulo,
    required this.text1,
    required this.icon,
    this.onTap,
  });

  @override
  State<CardAdmin> createState() => _CardAdminState();
}

class _CardAdminState extends State<CardAdmin> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: colors.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título + ícone à direita
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: colors.textColor,
                      ),
                    ),
                  ),
                  //Color(0xFFF5F7FA)
                  Icon(widget.icon, color: colors.iconColor, size: 30),
                ],
              ),
              const SizedBox(height: 8),
              // Descrição + ícone de seta
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.text1,
                      style: TextStyle(
                        fontSize: 16,
                        color: colors.descColor,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_right_alt, color: colors.iconColor, size: 35),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
