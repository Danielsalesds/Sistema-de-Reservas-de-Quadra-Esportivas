import 'package:clube/ui/pages/GerenciarQuadra.dart';
import 'package:clube/ui/pages/ReservaQuadraScreen.dart';
import 'package:clube/ui/pages/cadastro_membro.dart';
import 'package:clube/ui/pages/listar_membro.dart';
import 'package:clube/ui/widgets/CardAdmin.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:clube/ui/widgets/boasVindasCarde.dart';
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
  final double padding_card_h = 14;
  final double padding_card_v = 5;
  Color textColor = const Color(0xFF1A1A1A);//F5F5F5
  Color descColor = const Color(0xFF3A3A3A);
  Color baseColor = const Color(0xFF4A90E2);
  Color cardColor2 = const Color(0xFF5A9BD4);
  Color buttonColor = const Color(0xFF2F80ED);

  Color backgroundTela = const Color(0xFFF5F7FA);
  Color uberBlack = const Color(0xFF1C1C1E);
  Color iconeColor = const Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundTela,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40), // Altura menor que o padrão (56)
        child: AppBar(
          backgroundColor: baseColor,
          elevation: 0, // opcional: remove a sombra
          title: null, // sem título
          automaticallyImplyLeading: false, // opcional: remove ícone de voltar, se não quiser
        ),
      ),
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
          WelcomeCard(),
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