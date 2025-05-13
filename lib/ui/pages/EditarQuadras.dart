import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/ErroDialog.dart';
import 'package:clube/ui/widgets/SucessDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/FirestoreService.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomFAB.dart';
import '../widgets/CustomTextFormField.dart';
import 'ReservaQuadraScreen.dart';

class EditarQuadras extends StatefulWidget{
  final String nome,tipoQuadra, id;
  final int capacidade;
  final bool status;

  const EditarQuadras({super.key, required this.nome,
    required this.tipoQuadra, required this.capacidade, required this.status, required this.id});
  @override
  State<StatefulWidget> createState() => EditarQuadrasState();

}

class EditarQuadrasState extends State<EditarQuadras>{
  final nomeTextController = TextEditingController();
  final capacidadeTextController = TextEditingController();
  String? tipoQuadraId;
  bool status = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  void init(){
    setState(() {
      nomeTextController.text = widget.nome;
      capacidadeTextController.text = widget.capacidade.toString();
      status =  widget.status;
      tipoQuadraId = widget.tipoQuadra;
    });
  }
  void edit(){
    try{
      final firestore = Provider.of<FirestoreService>(context, listen:false);
      firestore.editQuadra({
        'nome':nomeTextController.text,
        'capacidade':int.parse(capacidadeTextController.text),
        'tipoQuadraId':tipoQuadraId,
        'status':status,
      },widget.id);
      showSucessDialog(context,"A quadra foi editada!");
    }catch(e){
      showErrorDialog(context, e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context, listen:false);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Editar quadras'),
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
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(top: 50, left: 35),
              child:Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Informações da quadra",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            // Padding(padding: const EdgeInsets.only(top: 5, left: 35),
            //   child:Row( mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Flexible(child: Text("Gerencie o perfil e configurações do usuário abaixo.",
            //         style: TextStyle(
            //           fontSize: 16,
            //           color: Theme.of(context).colorScheme.primary,
            //         ),
            //       ),)
            //     ],
            //   ),
            // ),
            const SizedBox(height: 50,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Nome", controller: nomeTextController,),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Capacidade", controller: capacidadeTextController, keyboardType: const TextInputType.numberWithOptions(signed: false),), ),
              ],
            ),
            const SizedBox(height: 20,),
            StreamBuilder<QuerySnapshot>(
                stream: firestore.geAllTipoQuadra(),
                builder:  (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  var tipos = snapshot.data!.docs;
                  return DropdownButton<String>(
                    value: tipoQuadraId,hint: Text('Selecione o tipo de quadra'),items: tipos.map((DocumentSnapshot doc) {
                    String nome = doc['nome'];
                    String id = doc['id'];
                    return DropdownMenuItem<String>(
                      value: id,child: Text(nome),);}).toList(),
                    onChanged: (String? novoTipo) {
                      setState(() {
                        tipoQuadraId = novoTipo;
                      });
                    },);
                }),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('Status',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),
                Switch(
                  value: status,
                  onChanged: (bool value) {
                    setState(() {
                      status = value;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 30,),
            CustomButton(height: 85, width: 250, text: "Atualizar", onclick: edit),
          ],
        ),
      ),
    );
  }
}