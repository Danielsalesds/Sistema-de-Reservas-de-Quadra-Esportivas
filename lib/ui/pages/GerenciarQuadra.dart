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
  final nomeTextController = TextEditingController();
  String? tipoQuadraId;
  bool status = false;
  void create(){
    final firestore = Provider.of<FirestoreService>(context, listen:false);
    try{
      firestore.createQuadra(nomeTextController.text,localizacaoTextController.text, status, int.parse(capacidadeTextController.text), tipoQuadraId!);
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
                Expanded(child: CustomTextFormField(label: "Nome", controller: nomeTextController,),),
              ],
            ),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Localização", controller: localizacaoTextController,),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Capacidade", controller: capacidadeTextController, keyboardType: const TextInputType.numberWithOptions(signed: false),), ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(children: [
              Padding(padding: EdgeInsets.only(left:  35),
                child:StreamBuilder<QuerySnapshot>(
                    stream: firestore.geAllTipoQuadra(),
                    builder:  (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      var tipos = snapshot.data!.docs;
                      return SizedBox(width: 300,
                        child: DropdownButton<String>(
                          value: tipoQuadraId,hint: Text('Selecione o tipo de quadra'), items: tipos.map((DocumentSnapshot doc) {
                          String nome = doc['nome'];
                          String id = doc['id'];
                          return DropdownMenuItem<String>(
                            value: id,child: Text(nome,
                              style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                              ),
                          ),);}).toList(),
                          onChanged: (String? novoTipo) {
                            setState(() {
                              tipoQuadraId = novoTipo;
                            });
                          },
                        isExpanded: true,),);
                    }),
              ),
              Icon(Icons.add),
            ],),
            const SizedBox(height: 20,),
            Row(
              children: [
                Padding(padding: const EdgeInsets.only(left: 35,),
                  child: Text('Status',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
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