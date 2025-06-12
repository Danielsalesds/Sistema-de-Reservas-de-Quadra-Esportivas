import 'package:clube/ui/widgets/CustomPasswordFormField.dart';
import 'package:clube/ui/widgets/ErroDialog.dart';
import 'package:clube/ui/widgets/SucessDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomBottomBar.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/CustomFAB.dart';

class EditarSenha extends StatefulWidget{
  const EditarSenha({super.key});

  @override
  State<StatefulWidget> createState() => EditarSenhaState();

}

class EditarSenhaState extends State<EditarSenha> {

  @override
  Widget build(BuildContext context) {
    final atualTextController = TextEditingController();
    final novaTextController = TextEditingController();
    final confirmarTextController = TextEditingController();
    String? validatePassword(String? password) {
      if (password == null || password.isEmpty) {
        return 'Digite uma senha';
      }
      if (password.length < 8) {
        return 'Mínimo de 8 caracteres';
      }
      if (!password.contains(RegExp(r'[A-Z]'))) {
        return 'Inclua 1 letra maiúscula';
      }
      if (!password.contains(RegExp(r'[a-z]'))) {
        return 'Inclua 1 letra minúscula';
      }
      if (!password.contains(RegExp(r'[0-9]'))) {
        return 'Inclua 1 número';
      }
      if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return 'Inclua 1 caractere especial';
      }
      return null;
    }

    void resetPassword() async{
      try{
        final regex = RegExp(
          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
        );

        if(novaTextController.text != confirmarTextController.text){
          showErrorDialog(context,"As senhas digitadas são diferentes!");
          return;
        }
        if(!regex.hasMatch(novaTextController.text)){
          String? error = validatePassword(novaTextController.text);
          showErrorDialog(context, error!);
          return;
        }

        User? user = FirebaseAuth.instance.currentUser;
        var credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: atualTextController.text,
        );

        await user.reauthenticateWithCredential(credential);
        await FirebaseAuth.instance.currentUser?.updatePassword(novaTextController.text);

        showSucessDialog(context, "Sua senha foi alterada!" );
      }catch(e){
        showErrorDialog(context, e.toString());
      }
    }
    return Scaffold(
      appBar: const CustomAppBar(title: 'Editar senha'),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: const CustomFAB(),
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
                height: 85, width: 250, text: "Atualizar", onclick: resetPassword),
          ],
        ),
      ),
    );
  }
}