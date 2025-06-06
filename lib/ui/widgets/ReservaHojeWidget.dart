import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../theme/AppColors.dart';

class ReservaHojeWidget extends StatelessWidget {
  final DocumentSnapshot reserva;
  final VoidCallback? onTap;

  const ReservaHojeWidget({
    Key? key,
    required this.reserva,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final data = reserva.data() as Map<String, dynamic>;
    final quadraId = data['idQuadra'] ?? '';
    final status = data['status'] ?? false;
    final tipoQuadraId = data['tipoQuadraId'] ?? '';

    String formattedTime = 'Hora inválida';
    try {
      final timestamp = data['dataHora'] as Timestamp;
      final dateTime = timestamp.toDate();
      formattedTime = DateFormat('HH:mm').format(dateTime);
    } catch (_) {}

    return FutureBuilder<List<DocumentSnapshot>>(
      future: Future.wait([
        FirebaseFirestore.instance.collection('quadras').doc(quadraId).get(),
        FirebaseFirestore.instance.collection('tipoQuadra').doc(tipoQuadraId).get(),
      ]),
      builder: (context, snapshot) {
        String nomeQuadra = 'Carregando...';
        String tipoQuadra = 'Carregando...';

        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final quadraData = snapshot.data![0].data() as Map<String, dynamic>?;
          nomeQuadra = quadraData?['nome'] ?? 'Quadra não encontrada';

          final tipoQuadraData = snapshot.data![1].data() as Map<String, dynamic>?;
          tipoQuadra = tipoQuadraData?['nome'] ?? 'Tipo não encontrado';
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          elevation: 2,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Status indicator
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: status ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: status ? Colors.green : Colors.red,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      status ? Icons.check : Icons.cancel,
                      color: status ? Colors.green : Colors.red,
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Informações da reserva
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nomeQuadra,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: colors.textColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.sports_tennis,
                              size: 14,
                              color: colors.textColor.withOpacity(0.6),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                tipoQuadra,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colors.textColor.withOpacity(0.7),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Horário
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: colors.cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          formattedTime,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: colors.textColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        status ? 'Confirmada' : 'Cancelada',
                        style: TextStyle(
                          fontSize: 12,
                          color: status ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}