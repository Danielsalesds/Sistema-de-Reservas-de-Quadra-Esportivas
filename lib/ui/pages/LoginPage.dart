import 'package:clube/ui/widgets/CustomButton.dart';
import 'package:clube/ui/widgets/CustomPasswordFormField.dart';
import 'package:clube/ui/widgets/CustomTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RegisterPage.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginPageState();

}
class LoginPageState extends State<LoginPage>{
  void notNull(){
    print("NotNull!");
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
                  ),child:ClipOval(child:Image.asset('assets/running.png', width: 150,height: 150,fit: BoxFit.cover),),
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
          Text("Faça login para gerenciar suas atividades esportivas.",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30,),
          const Row(
            children: [
              Expanded(child: CustomTextFormField(label: "Email"),),
            ],
          ),
          const SizedBox(height: 10,),
          const Row(
            children: [
              Expanded(child: CustomPasswordFormField(labelText: "Senha"),),
            ],
          ),
          const SizedBox(height: 5,),
          Padding(padding: const EdgeInsets.only(right: 25),
            child:  Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: notNull,
                  child: Text("Esqueceu a senha?", style: TextStyle(fontSize: 16,),),),
            ),
          ),
          const SizedBox(height: 10,),
          CustomButton(height: 85, width: 250, text: "Entrar", onclick: notNull,),
          const SizedBox(height: 30,),
          Text("Não possui uma conta?",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          Align(
            child:TextButton(
              onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=> RegisterPage()));
              },
              child: Text("Criar conta",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )
                ,)
              ,),
          ),


        ],
      )
    );
  }

}