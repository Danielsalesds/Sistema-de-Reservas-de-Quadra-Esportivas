import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/services/FirestoreService.dart';
import 'package:clube/services/AuthService.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:clube/ui/widgets/CustomAlert.dart';
import 'package:clube/theme/AppColors.dart';
import 'ReservaQuadraScreen.dart';
import 'EditarReservaScreen.dart';
import 'package:intl/intl.dart';

class ListarReservasScreen extends StatelessWidget {
  const ListarReservasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context, listen: false);
    final auth = Provider.of<AuthService>(context, listen: false);
    final userId = auth.getCurrentUser();
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Minhas Reservas'),
      bottomNavigationBar: const CustomBottomBar(index:2),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CustomFAB(),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: firestore.getReservasDoUsuario(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('Nenhuma reserva encontrada.'));
              }

              final docs = snapshot.data!.docs.where((doc) {
                 final data = doc.data() as Map<String, dynamic>;
                final timestamp = data['dataHora'];
                if (timestamp is Timestamp) {
                 final reservaDateTime = timestamp.toDate();
                return reservaDateTime.isAfter(DateTime.now());
                }
               return false;
                }).toList();

              return ListView.builder(
                itemCount: docs.length,
                padding: const EdgeInsets.only(bottom: 80), // Espaço para o botão flutuante
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final reservaId = doc.id;
                  final data = doc.data() as Map<String, dynamic>;
                  final quadraId = data['idQuadra'] ?? '';
                  final membroId = data['idMembro'] ?? '';
                  final status = data['status'] ?? false;
                  final tipoQuadraId = data['tipoQuadraId'] ?? '';

                  String formattedDate = 'Data inválida';
                  DateTime? reservaDateTime;
                  try {
                    final timestamp = data['dataHora'] as Timestamp;
                    reservaDateTime = timestamp.toDate();
                    formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(reservaDateTime);
                  } catch (_) {}

                  return FutureBuilder<List<DocumentSnapshot>>(
                    future: Future.wait([
                      FirebaseFirestore.instance.collection('quadras').doc(quadraId).get(),
                      FirebaseFirestore.instance.collection('membros').doc(membroId).get(),
                      FirebaseFirestore.instance.collection('tipoQuadra').doc(tipoQuadraId).get(),
                    ]),
                    builder: (context, snapshot) {
                      String nomeQuadra = 'Carregando...';
                      String nomeUsuario = 'Carregando...';
                      String tipoQuadra = 'Carregando...';
                      
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        // Dados da quadra
                        final quadraData = snapshot.data![0].data() as Map<String, dynamic>?;
                        nomeQuadra = quadraData?['nome'] ?? 'Quadra não encontrada';
                        
                        // Dados do usuário
                        final membroData = snapshot.data![1].data() as Map<String, dynamic>?;
                        nomeUsuario = membroData?['nome'] ?? 'Usuário não encontrado';
                        
                        // Dados do tipo de quadra
                        final tipoQuadraData = snapshot.data![2].data() as Map<String, dynamic>?;
                        tipoQuadra = tipoQuadraData?['nome'] ?? 'Tipo não encontrado';
                      }

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text('Quadra: $nomeQuadra'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tipo: $tipoQuadra'),
                              Text('Usuário: $nomeUsuario'),
                              Text('Data/Hora: $formattedDate'),
                              Text('Status: ${status ? "Confirmada" : "Cancelada"}',
                                style: TextStyle(
                                  color: status ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Apenas mostrar os botões se a reserva estiver ativa e não for no passado
                              if (status && reservaDateTime != null && reservaDateTime.isAfter(DateTime.now()))
                                IconButton(
                                  icon: Icon(Icons.edit, color: colors.textColor),
                                  onPressed: () {
                                    // Navegação para a tela de edição de reserva
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditarReservaScreen(
                                          reservaId: reservaId,
                                          dataHora: reservaDateTime!,
                                          tipoQuadraId: tipoQuadraId,
                                          quadraId: quadraId,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              if (status && reservaDateTime != null && reservaDateTime.isAfter(DateTime.now()))
                                IconButton(
                                  icon: Icon(Icons.cancel, color: colors.textColor),
                                  onPressed: () async {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.scale,
                                      title: "Alerta!",
                                      desc: "Tem certeza que deseja cancelar esta reserva?",
                                      btnOkText: "Sim",
                                      btnOkColor: colors.okBtnColor,
                                      btnOkOnPress: () async {
                                        await firestore.cancelarReserva(reservaId);
                                        AlertaFlutuante.mostrar(
                                          context: context,
                                          mensagem: 'Reserva cancelada com sucesso!',
                                          cor: colors.cancelBtnColor,
                                          alinhamento: Alignment.topCenter,
                                        );
                                      },
                                      btnCancelColor: colors.cancelBtnColor,
                                      btnCancelText: "Não",
                                      btnCancelOnPress: () {},
                                      titleTextStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                      descTextStyle: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).colorScheme.tertiary,
                                      ),
                                      buttonsTextStyle: TextStyle(color: colors.backgroundColor),
                                    ).show();
                                  },
                                ),
                              if (!status || (reservaDateTime != null && reservaDateTime.isBefore(DateTime.now())))
                                Icon(
                                  status ? Icons.check_circle : Icons.cancel,
                                  color: status ? Colors.green : Colors.red,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),

          Positioned(
            bottom: 10,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReservaQuadraScreen()),
              ),
              backgroundColor: colors.cardColor,
              shape: const CircleBorder(),
              elevation: 6,
              child: Icon(Icons.event, color: colors.textColor),
            ),
          ),
        ],
      ),
    );
  }
}