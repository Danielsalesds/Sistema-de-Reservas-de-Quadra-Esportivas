import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/ui/widgets/AddMembroButton.dart';
import 'package:clube/ui/widgets/AletMessage.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/cunstomAlert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/FirestoreService.dart';
import '../widgets/CustomFAB.dart';
import 'ReservaQuadraScreen.dart';

class ListarMembro extends StatefulWidget {
  const ListarMembro({super.key});

  @override
  State<ListarMembro> createState() => _ListarMembroState();
}

class _ListarMembroState extends State<ListarMembro> {

  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Gerenciar Membros',),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: CustomFAB(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReservaQuadraScreen()),
            );
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     body: Stack(
        children: [
          // Conteúdo principal (o StreamBuilder que já existe)
          StreamBuilder(
            stream: firestore.getMembrosDoAdmin(uid!),
            builder: (context, snapshot) {
              print("UID do admin logado: $uid");

              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

              final membros = snapshot.data!.docs;

              if (membros.isEmpty) return Center(child: Text('Nenhum membro cadastrado.'));

              return ListView.builder(
                itemCount: membros.length,
                itemBuilder: (context, index) {
                  final doc = membros[index];
                  final data = doc.data() as Map<String, dynamic>;

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(data['nome'] ?? ''),
                      subtitle: Text(data['email'] ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              print("Em desenvolvimento!");
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.scale,
                                title: "Alerta!",
                                desc:"Tem certeza que deseja desativar este usuário?",
                                btnOkText: "SIM",
                                btnOkColor: Theme.of(context).colorScheme.primaryContainer,
                                btnOkOnPress: () async {
                                  await firestore.atualizarMembro(doc.id, {
                                    'ativo': false,
                                  });
                                  AlertaFlutuante.mostrar(
                                    context: context,
                                    mensagem: 'Membro desativado com sucesso!',
                                    cor: Colors.red,
                                    alinhamento: Alignment.topCenter, // ou bottomCenter, center...
                                  );
                                },
                                btnCancelColor: Theme.of(context).colorScheme.errorContainer,
                                btnCancelText: "NÃO",
                                btnCancelOnPress: (){
                                },
                                titleTextStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ).show();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Botão flutuante adicional no canto inferior direito
          Positioned(
            bottom: 16,
            right: 16,
            child: AddButton(
              onTap: () {
                Navigator.pushNamed(context, '/CadastroMembro');
              },
            ),
          ),
        ],
      ),

    );
  }
}
