import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/ui/pages/EditUser.dart';
import 'package:clube/ui/widgets/AddMembroButton.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomAlert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/FirestoreService.dart';
import '../../theme/AppColors.dart';
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
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gerenciar Membros',),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     body: Stack(
        children: [
          // Conteúdo principal (o StreamBuilder que já existe)
          StreamBuilder(
            stream: firestore.getMembrosAtivos(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

              final membros = snapshot.data!.docs;

              if (membros.isEmpty) return const Center(child: Text('Nenhum membro cadastrado.'));
              membros.sort((a,b){
                return a['nome'].toLowerCase().compareTo(b['nome'].toLowerCase());
              });
              return Padding(padding: const EdgeInsets.only(bottom: 40),
                child: ListView.builder(
                  itemCount: membros.length,
                  itemBuilder: (context, index) {
                    final doc = membros[index];
                    final id = doc.id;
                    final data = doc.data() as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(data['nome'] ?? ''),
                        subtitle: Text(data['email'] ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: colors.textColor),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>EditUserPage(
                                      nome: data['nome'] ?? '',
                                      email: data['email'] ?? '',
                                      telefone: data['telefone'] ?? '',
                                      tipo: data['tipo'] ?? '',
                                      id: id,
                                    )
                                    )
                                );
                              },
                            ),
                            IconButton(
                              icon:Icon(Icons.delete, color: colors.textColor),
                              onPressed: () async {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.scale,
                                  title: "Alerta!",
                                  desc:"Tem certeza que deseja desativar este usuário?",
                                  btnOkText: "Sim",
                                  btnOkColor:colors.okBtnColor,
                                  btnOkOnPress: () async {
                                    await firestore.atualizarMembro(doc.id, {
                                      'ativo': false,
                                    });
                                    AlertaFlutuante.mostrar(
                                      context: context,
                                      mensagem: 'Membro desativado com sucesso!',
                                      cor: colors.cancelBtnColor,
                                      alinhamento: Alignment.topCenter, // ou bottomCenter, center...
                                    );
                                  },
                                  btnCancelColor: colors.cancelBtnColor,
                                  btnCancelText: "Não",
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
                                  buttonsTextStyle: TextStyle(color: colors.backgroundColor),
                                ).show();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          // Botão flutuante adicional no canto inferior direito
          Positioned(
            bottom: 10,
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
