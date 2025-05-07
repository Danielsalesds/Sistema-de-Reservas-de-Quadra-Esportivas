import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/services/AuthService.dart';
import 'package:clube/ui/widgets/CustomButton.dart';
import 'package:clube/ui/widgets/CustomTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget{
  const ResetPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => ResetPasswordPageState();

}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  final emailTextController =  TextEditingController();

  void reset() async{
    try{
      final auth = Provider.of<AuthService>(context,listen:false);
      await auth.resetPassword(emailTextController.text);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: 70),
            child: Flexible(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),child:SvgPicture.asset('assets/forgot-password.svg', width: 250,height: 200),
                  ),
                ]
            ),
            ),
          ),
          Text('Esqueceu a senha?',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              )
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Flexible(
                child: Text('Informe o e-mail cadastrado e enviaremos instruções para redefinir sua senha.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          CustomTextFormField(label: "Email", controller: emailTextController,),
          const SizedBox(height: 40,),
          CustomButton(height: 85, width: 250, text: "Redefinir senha", onclick: reset),
        ],
      ),
    ),
    );
  }
}