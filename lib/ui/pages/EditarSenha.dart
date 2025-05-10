import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/ui/widgets/CustomPasswordFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/AuthService.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomBottomBar.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomFAB.dart';
import '../widgets/CustomTextFormField.dart';
import 'ReservaQuadraScreen.dart';

class EditarSenha extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => EditarSenhaState();

}

class EditarSenhaState extends State<EditarSenha> {

  @override
  Widget build(BuildContext context) {
    final atualTextController = TextEditingController();
    final novaTextController = TextEditingController();
    final confirmarTextController = TextEditingController();


    void reset() async{
      try{
        await FirebaseAuth.instance.currentUser?.updatePassword('');
        if(!mounted) return;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: "Email enviado!",
          desc:  "Acesse seu email para redefinir sua senha.",
          btnOkText: "Entendi",
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
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      }
    }
    return Scaffold(
      appBar: const CustomAppBar(title: 'Editar senha'),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: CustomFAB(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ReservaQuadraScreen()),
            );
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(top: 50, left: 35),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Editar senha",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 5, left: 35),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child: Text("Altere sua senha atual.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),)
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Row(
              children: [
                Expanded(child: CustomPasswordFormField(
                  labelText: 'Senha atual', controller: atualTextController,)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomPasswordFormField(
                  labelText: 'Nova senha', controller: novaTextController,),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomPasswordFormField(
                  labelText: 'Confirmar senha',
                  controller: confirmarTextController,),),
              ],
            ),
            const SizedBox(height: 70,),
            CustomButton(
                height: 85, width: 250, text: "Atualizar", onclick: null),
          ],
        ),
      ),
    );
  }
}