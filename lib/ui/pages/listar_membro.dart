import 'package:clube/ui/widgets/AddMembroButton.dart';
import 'package:clube/ui/widgets/AletMessage.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/cunstomAlert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/FirestoreService.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Floating Action Button Pressed");
        },
        elevation: 6,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: ShapeBorder.lerp(
          const CircleBorder(),
          const StadiumBorder(),
          0.5,
        ),
        child: const Icon(Icons.add, color: Colors.white,),
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
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
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
