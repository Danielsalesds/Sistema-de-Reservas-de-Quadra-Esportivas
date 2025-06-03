import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/services/FirestoreService.dart';
import 'package:clube/ui/pages/GerenciarTipoQuadra.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/AppColors.dart';
import '../widgets/CustomAlert.dart';
import 'EditarTipoQuadra.dart';

class ListarTipoQuadras extends StatefulWidget{

  const ListarTipoQuadras({super.key});

  @override
  State<StatefulWidget> createState() => ListarTipoQuadrasState();
  
}

class ListarTipoQuadrasState extends State<ListarTipoQuadras> {


  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context,listen: false);
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gerenciar tipos quadra'),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(children: [
        StreamBuilder(
            stream: firestore.getAllTipoQuadra(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final tipos = snapshot.data!.docs;

              if (tipos.isEmpty) {
                return const Center(child: Text('Nenhuma quadra cadastrada.'));
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: ListView.builder(
                  itemCount: tipos.length,
                  itemBuilder: (context, index) {
                    final doc = tipos[index];
                    final nome = doc['nome'];
                    return Card(
                      // color: status ? colors.activeColor : colors.inactiveColor,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(
                          nome,
                          style: TextStyle(color: colors.textColor),
                        ),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: colors.iconColor),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditarTipoQuadra(
                                            nome: nome ?? '',
                                            id: doc.id,
                                          )));
                            },
                          ),
                              IconButton(
                            icon: Icon(Icons.delete, color: colors.iconColor),
                            onPressed: () async {
                              String desc = 'Ao excluir esse tipo de quadra, todas as quadras desse tipo serão desativadas.';
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.scale,
                                title: "Alerta!",
                                desc: desc,
                                btnOkText: "Sim",
                                btnOkColor: colors.okBtnColor,
                                btnOkOnPress: () async {
                                  await firestore.deleteTipoQuadra(doc.id);
                                  String msg = 'Tipo de Quadra excluido com sucesso!';
                                  AlertaFlutuante.mostrar(
                                    context: context,
                                    mensagem: msg,
                                    cor: Colors.red,
                                    alinhamento: Alignment.topCenter,
                                  );
                                },
                                btnCancelColor: colors.cancelBtnColor,
                                btnCancelText: "Não",
                                btnCancelOnPress: () {},
                                titleTextStyle: TextStyle(
                                    color:
                                    Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                                descTextStyle: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                                buttonsTextStyle:
                                TextStyle(color: colors.backgroundColor),
                              ).show();
                            }
                          )
                        ]),
                      ),
                    );
                  },
                ),
              );
            }),
        Positioned(
          bottom: 10,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>GerenciarTipoQuadra()),
            ),
            backgroundColor: colors.cardColor,
            shape: const CircleBorder(),
            elevation: 6,
            child: Icon(Icons.sports_tennis, color: colors.textColor),
          ),
        ),
      ]),
    );
  }
  
}