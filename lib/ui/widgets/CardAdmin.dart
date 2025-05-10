import 'package:flutter/material.dart';

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
  static const Color textColor = Color(0xFF1A1A1A); // Branco suave
  Color descColor = const Color.fromARGB(255, 58, 58, 58);
  static const Color cardColor = Color(0xFF4A90E2); // Azul principal
  Color backgroundTela = const Color(0xFFF5F7FA);
  Color uberBlack = const Color(0xFF1C1C1E);
  Color iconeColor = const Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: cardColor,
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
                        color: uberBlack,
                      ),
                    ),
                  ),
                  Icon(widget.icon, color: const Color(0xFFF5F7FA), size: 30),
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
                        color: descColor,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_right_alt, color: iconeColor, size: 35),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
