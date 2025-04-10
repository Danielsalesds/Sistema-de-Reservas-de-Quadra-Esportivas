import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/services/FirestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/CustomButton.dart';
import '../widgets/CustomTextFormField.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfilePageState();

}

class ProfilePageState extends State<ProfilePage> {
  final nomeTextController =  TextEditingController();
  final emailTextController =  TextEditingController();
  final telefoneTextController =  TextEditingController();
  @override
  void initState() {
    super.initState();
    init();
  }
  void init() async{
    final firebase = Provider.of<FirestoreService>(context,listen:false);
    final nome = await firebase.getData('nome');
    final email = await firebase.getData('email');
    final telefone = await firebase.getData('telefone');
    setState(() {
      nomeTextController.text = nome;
      emailTextController.text = email;
      telefoneTextController.text = telefone;
    });
  }
  void update()async{
    final firebase = Provider.of<FirestoreService>(context,listen:false);
    try{
      await firebase.updateProfile({'nome':nomeTextController.text,
        'email':emailTextController.text, 'telefone': telefoneTextController.text});
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
      );
    }finally{
      if(!mounted) return;
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: "Suas informações foram atualizadas!",
        btnOkText: "Ok",
        btnOkColor: Theme.of(context).colorScheme.primary,
        btnOkOnPress: () {
          Navigator.pop(context);
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
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50, left: 35),
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
            Padding(padding: EdgeInsets.only(top: 5, left: 35),
              child:Row( mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child: Text("Gerencie seu perfil e configurações da conta abaixo.",
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
                Expanded(child: CustomTextFormField(label: "Telefone", controller: telefoneTextController),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Email", controller: emailTextController), ),
              ],
            ),
            const SizedBox(height: 70,),
            CustomButton(height: 85, width: 250, text: "Atualizar", onclick: update),
          ],
        ),
      ),
    );
  }

}