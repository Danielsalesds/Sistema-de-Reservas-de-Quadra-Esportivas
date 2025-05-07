import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clube/ui/pages/GerenciarTipoQuadra.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/FirestoreService.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomBottomBar.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomFAB.dart';
import '../widgets/CustomTextFormField.dart';
import 'ReservaQuadraScreen.dart';

class GerenciarQuadra extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => GerenciarQuadraState();
}

class GerenciarQuadraState extends State<GerenciarQuadra>{
  final capacidadeTextController = TextEditingController();
  final localizacaoTextController = TextEditingController();
  String? tipoQuadraId;
  bool status = false;
  void create(){
    final firestore = Provider.of<FirestoreService>(context, listen:false);
    try{
      firestore.createQuadra(localizacaoTextController.text, status, int.parse(capacidadeTextController.text), tipoQuadraId!);
    }catch (e){
      throw Exception(e);
    }
  }
  void tipo(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>GerenciarTipoQuadra()));
  }
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context, listen:false);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gerenciar quadras',),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Localização:", controller: localizacaoTextController,),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Capacidade", controller: capacidadeTextController, keyboardType: const TextInputType.numberWithOptions(signed: false),), ),
              ],
            ),
            const SizedBox(height: 10,),
            StreamBuilder<QuerySnapshot>(
                    stream: firestore.getTipoQuadra(),
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
            CustomButton(height: 85, width: 250, text: "Cadastrar", onclick: create),
            CustomButton(height: 85, width: 250, text: "Tipo",onclick: tipo,)
          ],
        ),
      ),
    );
  }

}