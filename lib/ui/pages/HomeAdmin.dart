import 'package:clube/ui/pages/ReservaQuadraScreen.dart';
import 'package:clube/ui/widgets/CardAdmin.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeMembro2.dart';
import 'home_membro.dart';

class HomeAdmin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeAdminState();

}
class HomeAdminState extends State<HomeAdmin>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Painel de Admin',),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Floating Action Button Pressed");
        },
        elevation: 6,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: ShapeBorder.lerp(
          const CircleBorder(),
          const StadiumBorder(),
          0.5,
        ),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const Column(
        children: [
          const SizedBox(height: 5,),
          CardAdmin(titulo: "Fechar quadras", text1: "Feche quadras para manutenção.", icon: Icons.lock_outline_rounded),
          CardAdmin(titulo: "Gerenciar associados", text1: "Adicione ou remova associados.", icon: Icons.person_add_outlined),
          CardAdmin(titulo: "Fazer reserva", text1: "Reserve quadras sem restrições.", icon: Icons.sports_soccer_outlined),
        ],
      ),
    );
  }

}