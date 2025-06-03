import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/ErroDialog.dart';
import 'package:clube/ui/widgets/SucessDialog.dart';
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
      showSucessDialog(context, "Quadra criada com sucesso!");
    }catch (e){
      showErrorDialog(context, e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gerenciar Tipo Quadras'),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),child:ClipOval(child:Image.asset('assets/tennis.png', width: 250,height: 200,fit: BoxFit.cover),),
                  ),
                ]
            ),
            Text("Adicionar Novo Tipo de Quadra",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            const SizedBox(height: 50,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Nome:", controller: nomeTextController,),),
              ],
            ),
            const SizedBox(height: 50,),
            CustomButton(height: 85, width: 250, text: "Cadastrar", onclick: create),
          ],
        ),
      ),
    );
  }

}
