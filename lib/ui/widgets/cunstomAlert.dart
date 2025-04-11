import 'package:flutter/material.dart';

class AlertaFlutuante {
  static void mostrar({
    required BuildContext context,
    required String mensagem,
    Color cor = Colors.green,
    Duration duracao = const Duration(seconds: 3),
    AlignmentGeometry alinhamento = Alignment.topCenter,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: SafeArea(
          child: Align(
            alignment: alinhamento,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 20),
                  decoration: BoxDecoration(
                    color: cor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    mensagem,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duracao, () => overlayEntry.remove());
  }
}
