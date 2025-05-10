import 'package:clube/ui/pages/GerenciarQuadra.dart';
import 'package:clube/ui/pages/ReservaQuadraScreen.dart';
import 'package:clube/ui/pages/cadastro_membro.dart';
import 'package:clube/ui/pages/listar_membro.dart';
import 'package:clube/ui/widgets/CardAdmin.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeMembro2.dart';
import 'ListarQuadras.dart';
import 'home_membro.dart';

class HomeAdmin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeAdminState();

}
class HomeAdminState extends State<HomeAdmin>{
  final double paddingCardH = 14;
  final double paddingCardV = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home',),
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
      body: Column(
        children: [
          const SizedBox(height: 5),
          buildCardAdmin(
              context,
              "Gerenciar quadras",
              "Adicione, edite ou desative quadras.",
              Icons.assignment,
              ListarQuadras()
          ),
          buildCardAdmin(
              context,
              "Gerenciar associados",
              "Adicione ou remova associados.",
              Icons.person_add_outlined,
              const ListarMembro()
          ),
          buildCardAdmin(
              context,
              "Fazer reserva",
              "Reserve quadras sem restrições.",
              Icons.sports_soccer_outlined,
              const ReservaQuadraScreen()
          ),
        ],
      ),

    );
  }

  Padding buildCardAdmin(BuildContext context, String title, String text,IconData icon, Widget classe) {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingCardH, vertical: paddingCardV),
          child: CardAdmin(
            titulo: title,
            text1: text,
            icon: icon,
            onTap: () {
              // Exemplo de rota
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => classe), // ou outra tela
              );
            },
          ),
        );
  }

}