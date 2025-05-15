import 'package:clube/services/AuthService.dart';
import 'package:clube/ui/pages/ResetPasswordPage.dart';
import 'package:clube/ui/widgets/CustomButton.dart';
import 'package:clube/ui/widgets/CustomPasswordFormField.dart';
import 'package:clube/ui/widgets/CustomTextFormField.dart';
import 'package:clube/ui/widgets/ErroDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({super.key, this.onTap});
  final void Function()? onTap;

  @override
  State<StatefulWidget> createState() => LoginPageState();

}
class LoginPageState extends State<LoginPage>{
  final emailTextController = TextEditingController();
  final senhaTextController = TextEditingController();

  void signIn() async{
    final auth = Provider.of<AuthService>(context, listen: false);
    try{
      await auth.signIn(emailTextController.value.text, senhaTextController.value.text);
    }on FirebaseAuthException catch (e) {
      print("------ERROR: $e");
      if(!mounted) return;
      String error;
      switch (e.code) {
        case 'invalid-email':
          error = 'O e-mail fornecido não é válido.';
          break;
        case 'user-disabled':
          error = 'Esta conta foi desativada.';
          break;
        case 'user-not-found':
          error = 'Nenhuma conta encontrada para este e-mail.';
          break;
        case 'wrong-password':
          error = 'Senha incorreta. Tente novamente.';
          break;
        case 'too-many-requests':
          error = 'Muitas tentativas falhas. Tente novamente mais tarde.';
          break;
        case 'network-request-failed':
          error = 'Falha na conexão com a internet. Verifique sua rede.';
          break;
        case 'invalid-credential':
          error = 'A credencial fornecida está incorreta ou expirada.';
          break;
        default:
          error = 'Erro desconhecido. Tente novamente mais tarde.';
          break;
      }
      showErrorDialog(context, error);
    }catch(e){
      if (!mounted) return;
      showErrorDialog(context, 'Erro desconhecido. Tente novamente mais tarde.');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column( mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),child:ClipOval(child:Image.asset('assets/basketball2.png', width: 250,fit: BoxFit.cover),),
                ),
              ]
            ),
          ),
          const SizedBox(height: 10,),
          Text("Bem-vindo ao clube!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          const SizedBox(height: 30,),
          Row(
            children: [
              Expanded(child: CustomTextFormField(label: "Email", controller: emailTextController,),),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child: CustomPasswordFormField(labelText: "Senha", controller: senhaTextController,),),
            ],
          ),
          const SizedBox(height: 5,),
          Padding(padding: const EdgeInsets.only(right: 25),
            child:  Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordPage()));
                  },
                  child: const Text("Esqueceu a senha?", style: TextStyle(fontSize: 16,),),),
            ),
          ),
          const SizedBox(height: 10,),
          CustomButton(height: 85, width: 250, text: "Entrar", onclick: signIn),
          const SizedBox(height: 30,),
        ],
      )
    );
  }

}