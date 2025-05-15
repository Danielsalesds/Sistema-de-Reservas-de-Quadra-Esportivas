import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/ui/pages/EditarQuadras.dart';
import 'package:clube/ui/pages/GerenciarQuadra.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/FirestoreService.dart';
import '../../theme/AppColors.dart';
import '../widgets/CustomBottomBar.dart';
import '../widgets/CustomFAB.dart';
import '../widgets/CustomAlert.dart';
import 'ReservaQuadraScreen.dart';

class ListarQuadras extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => ListarQuadrasState();

}

class ListarQuadrasState extends State<ListarQuadras>{
  Map<String, String> tipos = {};
  bool isReady =  false;
  @override
  void initState() {

    init();
    super.initState();
  }
  void init()async{
    final firestore = Provider.of<FirestoreService>(context, listen: false);
    final Map<String, String> temp = await firestore.getAllTipoQuadraMap();
    setState(() {
      tipos = temp;
      isReady = !isReady;
    });
  }
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context, listen: false);
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: const CustomAppBar(title: 'Fechar quadras'),
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
      body:

        Stack(
          children: [
            StreamBuilder(
              stream: firestore.getQuadras(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || !isReady) return const Center(child: CircularProgressIndicator());

                final quadras = snapshot.data!.docs;

                if (quadras.isEmpty) return const Center(child: Text('Nenhuma quadra cadastrada.'));
                // Ordena a lista de quadras, primeiro pelo Status depois pelo tipo e por último pelo nome.
                quadras.sort((a,b){
                  int compareStatus = (b['status']? 1 : 0).compareTo(a['status'] ? 1 : 0);
                  if (compareStatus != 0) return compareStatus;
                  int compareTipo = tipos[a['tipoQuadraId']]!.toLowerCase().compareTo(tipos[a['tipoQuadraId']]!.toLowerCase());
                  if (compareTipo != 0) return compareTipo;
                  return a['nome'].toLowerCase().compareTo(b['nome'].toLowerCase());
                });
                return Padding(padding: const EdgeInsets.only(bottom: 40),
                child: ListView.builder(
                  itemCount: quadras.length,
                  itemBuilder: (context, index) {
                    final doc = quadras[index];
                    final nomeTipo = tipos[doc['tipoQuadraId']] ?? 'Tipo desconhecido';

                    final bool status = doc['status'];
                    final nome = doc['nome'];

                    return Card(
                      color: status ? colors.activeColor: colors.inactiveColor,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(nome,
                            style:TextStyle(
                              color: colors.textColor
                            ),
                        ),
                        subtitle: Text('Tipo: $nomeTipo',
                          style: TextStyle(color: colors.descColor),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: colors.iconColor),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>EditarQuadras(
                                      nome: nome ?? '',
                                      capacidade: doc['capacidade'] ?? '',
                                      status: status,
                                      tipoQuadra: doc['tipoQuadraId'] ?? '',
                                      id: doc.id,
                                    )
                                    )
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(status?Icons.block:Icons.check, color: colors.iconColor),
                              onPressed: () async {
                                String desc = status? 'Tem certeza que deseja desativar essa quadra?' : 'Tem certeza que deseja ativar essa quadra?';
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.scale,
                                  title: "Alerta!",
                                  desc:desc,
                                  btnOkText: "Sim",
                                  btnOkColor: colors.okBtnColor,
                                  btnOkOnPress: () async {
                                    await firestore.setStatusQuadra(doc.id);
                                    String msg = status? 'Quadra desativada com sucesso!' : 'Quadra está ativa';
                                    AlertaFlutuante.mostrar(
                                      context: context,
                                      mensagem: msg,
                                      cor: status? Colors.red : Colors.green,
                                      alinhamento: Alignment.topCenter,
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

            Positioned(
              bottom: 10,
              right: 16,
              child: FloatingActionButton(
                onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const CadastrarQuadra())),
                backgroundColor: colors.cardColor,
                shape: const CircleBorder(),
                elevation: 6,
                child: Icon(Icons.sports_volleyball, color: colors.textColor),
              )
            ),
          ],
        )
    );
  }

}