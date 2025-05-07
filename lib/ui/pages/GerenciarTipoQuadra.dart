import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/FirestoreService.dart';
import '../widgets/CustomBottomBar.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomFAB.dart';
import '../widgets/CustomTextFormField.dart';
import 'ReservaQuadraScreen.dart';

class GerenciarTipoQuadra extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => GerenciarTipoQuadraState();
}

class GerenciarTipoQuadraState extends State<GerenciarTipoQuadra>{
  final nomeTextController = TextEditingController();
  void create(){
    final firestore = Provider.of<FirestoreService>(context, listen:false);
    try{
      firestore.createTipoQuadra(nomeTextController.text);
    }catch (e){
      throw Exception(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gerenciar Tipo Quadras'),
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
                Expanded(child: CustomTextFormField(label: "Nome:", controller: nomeTextController,),),
              ],
            ),
            const SizedBox(height: 30,),
            CustomButton(height: 85, width: 250, text: "Cadastrar", onclick: create),
          ],
        ),
      ),
    );
  }

}
