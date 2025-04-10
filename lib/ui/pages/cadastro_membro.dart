import 'package:clube/services/AuthService.dart';
import 'package:clube/services/FirestoreService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/CustomButton.dart';
import '../widgets/CustomPasswordFormField.dart';
import '../widgets/CustomTextFormField.dart';
import 'LoginPage.dart';

class CadastroMembro extends StatefulWidget{
  

  const CadastroMembro({super.key});

  @override
  State<StatefulWidget> createState() => CadastroMembroPageState();

}
class CadastroMembroPageState extends State<CadastroMembro>{
  bool _isLoading = false;
  final emailTextController = TextEditingController();
  final senhaTextController = TextEditingController();
  final repSenhaTextController = TextEditingController();
  final nomeTextController = TextEditingController();
  final telefoneTextController = TextEditingController();
  final String tipo = 'Membro';
  //função fazer login
  void signUp() async{
    if(senhaTextController.text != repSenhaTextController.text){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Certifique-se de que os campos de senha sejam iguais."))
      );
      return;
    }
    if (nomeTextController.text.isEmpty || emailTextController.text.isEmpty || telefoneTextController.text.isEmpty || senhaTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preencha todos os campos.")));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen:false);
    final firestore = Provider.of<FirestoreService>(context, listen:false);
    setState(() {
      _isLoading = true;
    });
    try{
       //final adminUid = FirebaseAuth.instance.currentUser!.uid; // <- Salva o UID do admin
       
      //await authService.signUp(emailTextController.text, senhaTextController.text);
      await firestore.createMembro(nomeTextController.text,
          emailTextController.text, telefoneTextController.text, tipo, senhaTextController.text);

          nomeTextController.clear();
          telefoneTextController.clear();
          emailTextController.clear();
          senhaTextController.clear();
          repSenhaTextController.clear();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
      );
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(),)
          : SingleChildScrollView(
            child: Column( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),child:ClipOval(child:Image.asset('assets/basketball.png', width: 150,height: 150,fit: BoxFit.cover),),
                      ),
                    ]
                ),
                const SizedBox(height: 10,),
                Text("Cadastrar Novo Membro",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
                const SizedBox(height: 20,),
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
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: CustomPasswordFormField(labelText: "Senha", controller:senhaTextController),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: CustomPasswordFormField(labelText: "Confirmar senha", controller: repSenhaTextController,),),
                  ],
                ),
                const SizedBox(height: 10,),
                
                const SizedBox(height: 30,),
                CustomButton(height: 85, width: 250, text: "Cadastrar Membro", onclick: signUp),
                const SizedBox(height: 20,),
                
                Align(
                  child:TextButton(
                    onPressed: (){print("CLICADO");},
                    child: Text("<< Voltar >>",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )
                      ,)
                    ,),
                ),
              ],
            ),
          )

    );
  }

}