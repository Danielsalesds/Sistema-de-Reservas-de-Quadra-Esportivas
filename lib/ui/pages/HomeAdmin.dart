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
  final double padding_card_h = 14;
  final double padding_card_v = 5;

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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding_card_h, vertical: padding_card_v),
            child: CardAdmin(
              titulo: "Fechar quadras",
              text1: "Feche quadras para manutenção.",
              icon: Icons.lock_outline_rounded,
              onTap: () {
                // Exemplo de rota
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListarQuadras()), // ou outra tela
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding_card_h, vertical: padding_card_v),
            child: CardAdmin(
              titulo: "Gerenciar quadras",
              text1: "Editar e criar novas quadras",
              icon: Icons.lock_outline_rounded,
              onTap: () {
                // Exemplo de rota
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GerenciarQuadra()), // ou outra tela
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding_card_h, vertical:padding_card_v),
            child: CardAdmin(
              titulo: "Gerenciar associados",
              text1: "Adicione ou remova associados.",
              icon: Icons.person_add_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListarMembro()),
                );
              },
            ),
          ),

          Padding(
              padding: EdgeInsets.symmetric(horizontal: padding_card_h,vertical:  padding_card_v),
              child:CardAdmin(
                titulo: "Fazer reserva",
                text1: "Reserve quadras sem restrições.",
                icon: Icons.sports_soccer_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReservaQuadraScreen()),
                  );
                },
              ),
          ),
        ],
      ),

    );
  }

}