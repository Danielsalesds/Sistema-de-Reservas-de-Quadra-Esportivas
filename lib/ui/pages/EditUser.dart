import 'package:clube/services/FirestoreService.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/ErroDialog.dart';
import 'package:clube/ui/widgets/SucessDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/CustomBottomBar.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomFAB.dart';
import '../widgets/CustomTelFormField.dart';
import '../widgets/CustomTextFormField.dart';
import 'ReservaQuadraScreen.dart';

class EditUserPage extends StatefulWidget{
  final String nome, email, telefone, tipo, id;
  const EditUserPage({super.key, required this.nome, required this.email, required this.telefone, required this.tipo, required this.id});
  @override
  State<StatefulWidget> createState() => EditUserPageState();
}

class EditUserPageState extends State<EditUserPage> {
  final nomeTextController =  TextEditingController();
  final emailTextController =  TextEditingController();
  final telefoneTextController =  TextEditingController();
  String _selecionado = '';
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async{
    setState(() {
      nomeTextController.text = widget.nome;
      emailTextController.text = widget.email;
      telefoneTextController.text = widget.telefone;
      _selecionado = widget.tipo;
    });
  }
  void update()async{
    final firebase = Provider.of<FirestoreService>(context,listen:false);
    try{
      await firebase.updateUserProfile({'nome':nomeTextController.text,
        'email':emailTextController.text, 'telefone': telefoneTextController.text}, widget.id);
      if(!mounted) return;
      showSucessDialog(context, "As informações do usuário ${widget.nome} foram atualizadas!");
    }catch(e){
      showErrorDialog(context, e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Perfil'),
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
            Padding(padding: const EdgeInsets.only(top: 50, left: 35),
              child:Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Informações da conta",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 5, left: 35),
              child:Row( mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child: Text("Gerencie o perfil e configurações do usuário abaixo.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),)
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Nome completo", controller: nomeTextController,),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomTelFormField(label: "Telefone", controller: telefoneTextController),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Email", controller: emailTextController), ),
              ],
            ),
            const SizedBox(height: 20,),
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(value:  'Admin', groupValue: _selecionado, onChanged:(value){
                  setState(() {
                    _selecionado = value!;
                  });
                }),
                Text("Admin",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(width: 50,),
                Radio<String>(value: 'Membro', groupValue: _selecionado, onChanged:(value){
                  setState(() {
                    _selecionado = value!;
                  });
                }),
                Text("Membro",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            CustomButton(height: 85, width: 250, text: "Atualizar", onclick: update),
          ],
        ),
      ),
    );
  }
}

