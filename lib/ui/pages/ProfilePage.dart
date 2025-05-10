import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/services/FirestoreService.dart';
import 'package:clube/ui/pages/EditarSenha.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/CustomBottomBar.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomFAB.dart';
import '../widgets/CustomTelFormField.dart';
import '../widgets/CustomTextFormField.dart';
import 'EditProfilePage.dart';
import 'ReservaQuadraScreen.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfilePageState();

}

class ProfilePageState extends State<ProfilePage> {
  String nome=" ", email=" ", telefone=" ";
  @override
  void initState() {
    super.initState();
    init();
  }
  void init() async{
    final firebase = Provider.of<FirestoreService>(context,listen:false);
    final nome = await firebase.getUserField('nome');
    final email = await firebase.getUserField('email');
    final telefone = await firebase.getUserField('telefone');
    setState(() {
      this.nome = nome;
      this.email = email;
      this.telefone = telefone;
    });
  }
  void pushEditar(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
  }
  void pushSenha(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditarSenha()),
    );
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
            Padding(padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Flexible(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),
                        ),
                        child:SvgPicture.asset('assets/profile.svg', width: 250,height: 200),
                      ),
                    ]
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(nome, style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              ],
            ),

            const SizedBox(height: 5,),
            // buildPadding(context,"Nome"),
            // buildCont(context,nome,Icons.person),
            const SizedBox(height: 15,),
            buildPadding(context,"E-mail"),
            buildCont(context,email,Icons.email),
            const SizedBox(height: 15,),
            buildPadding(context,"Telefone"),
            buildCont(context,telefone,Icons.phone),
            const SizedBox(height: 30,),
            Row(
              children: [
                CustomButton(height: 80, width: 200, text: "Editar perfil", onclick: pushEditar),
                CustomButton(height: 80, width: 200, text: "Editar senha", onclick: pushSenha),
              ],
            )

          ],
        ),
      ),
    );
  }

  Padding buildCont(BuildContext context, String inf, IconData iconData) {
    return Padding(padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  Padding(padding: const EdgeInsets.all(10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(inf,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Icon(iconData, color: Theme.of(context).colorScheme.onSecondaryContainer),
                      ],
                    )
                  )

            )
            );
  }

  Padding buildPadding(BuildContext context,String text) {
    return Padding(padding: const EdgeInsets.only(top: 5, left: 35),
            child:Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("$text ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
  }

}