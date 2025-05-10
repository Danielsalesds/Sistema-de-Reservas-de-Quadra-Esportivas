import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/ui/pages/EditarQuadras.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/FirestoreService.dart';
import '../widgets/CustomBottomBar.dart';
import '../widgets/CustomFAB.dart';
import '../widgets/cunstomAlert.dart';
import 'ReservaQuadraScreen.dart';

class ListarQuadras extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => ListarQuadrasState();

}

class ListarQuadrasState extends State<ListarQuadras>{
  Map<String, String> tipos = {};
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
    });
  }
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context, listen: false);
    Color textColor = const Color(0xFF1A1A1A);//F5F5F5
    Color descColor = const Color(0xFF3A3A3A);
    Color baseColor = const Color(0xFF4A90E2);
    Color cardColor2 = const Color(0xFF5A9BD4);
    Color buttonColor = const Color(0xFF2F80ED);

    Color backgroundTela = const Color(0xFFF5F7FA);
    Color uberBlack = const Color(0xFF1C1C1E);
    Color iconeColor = const Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: backgroundTela,
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
      body:StreamBuilder(
        stream: firestore.getQuadras(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final quadras = snapshot.data!.docs;

          if (quadras.isEmpty) return const Center(child: Text('Nenhuma quadra cadastrada.'));

          return ListView.builder(
            itemCount: quadras.length,
            itemBuilder: (context, index) {
              final doc = quadras[index];
              final nomeTipo = tipos[doc['tipoQuadraId']] ?? 'Tipo desconhecido';

              final bool status = doc['status'];
              final nome = doc['nome'];

              return Card(
                color: status ? Colors.green.shade100 : Colors.red.shade100,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(nome),
                  subtitle: Text('Tipo: $nomeTipo'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>EditarQuadras(
                                nome: nome ?? '',
                                localizacao: doc['localizacao'] ?? '',
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
                        icon: Icon(status?Icons.block:Icons.check_circle, color: Colors.red),
                        onPressed: () async {
                          String desc = status? 'Tem certeza que deseja desativar essa quadra?' : 'Tem certeza que deseja ativar essa quadra?';
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.scale,
                            title: "Alerta!",
                            desc:desc,
                            btnOkText: "Sim",
                            btnOkColor: Theme.of(context).colorScheme.primaryContainer,
                            btnOkOnPress: () async {
                              await firestore.setStatusQuadra(doc.id);
                              String msg = status? 'Quadra desativada com sucesso!' : 'Quadra está ativa';
                              AlertaFlutuante.mostrar(
                                context: context,
                                mensagem: msg,
                                cor: status? Colors.red : Colors.green,
                                alinhamento: Alignment.topCenter, // ou bottomCenter, center...
                              );
                            },
                            btnCancelColor: Theme.of(context).colorScheme.errorContainer,
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
    );
  }

}