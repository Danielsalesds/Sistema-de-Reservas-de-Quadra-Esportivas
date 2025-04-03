import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/CustomButton.dart';
import '../widgets/CustomPasswordFormField.dart';
import '../widgets/CustomTextFormField.dart';
import 'LoginPage.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RegisterPageState();

}
class RegisterPageState extends State<RegisterPage>{
  void notNull(){
    print("NotNull!");
  }
  String? _selecionado = 'admin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:
          SingleChildScrollView(
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
                Text("Criar novo usuário",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
                const SizedBox(height: 20,),
                const Row(
                  children: [
                    Expanded(child: CustomTextFormField(label: "Nome completo"),),
                  ],
                ),
                const SizedBox(height: 10,),
                const Row(
                  children: [
                    Expanded(child: CustomTextFormField(label: "Telefone"),),
                  ],
                ),
                const SizedBox(height: 10,),
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
                const SizedBox(height: 10,),
                const Row(
                  children: [
                    Expanded(child: CustomPasswordFormField(labelText: "Confirmar senha"),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(value:  'admin', groupValue: _selecionado, onChanged:(value){
                      setState(() {
                        _selecionado = value!;
                      });
                    }),
                    Text("Admin",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(width: 50,),
                    Radio<String>(value: 'associado', groupValue: _selecionado, onChanged:(value){
                      setState(() {
                        _selecionado = value!;
                      });
                    }),
                    Text("Associado",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                CustomButton(height: 85, width: 250, text: "Criar conta", onclick: notNull,),
                const SizedBox(height: 20,),
                Text("Já possui uma conta?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Align(
                  child:TextButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> LoginPage()));
                    },
                    child: Text("Login",
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