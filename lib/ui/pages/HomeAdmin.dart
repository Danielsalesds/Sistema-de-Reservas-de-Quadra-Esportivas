import 'package:clube/ui/pages/ReservaQuadraScreen.dart';
import 'package:clube/ui/widgets/CardAdmin.dart';
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
      appBar: AppBar(
        title: Text('Painel de Admin', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFA7C7E7),Color(0xFF6B9AC4)],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
        ),
        actions: [
          IconButton(
              onPressed:(){ Navigator.pop(context); },
              icon: const Icon(Icons.logout),
              color: Theme.of(context).colorScheme.onPrimary)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primaryContainer,
        notchMargin: 6.0,
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          StadiumBorder(),
        ),
        child: IconTheme(
          data: const IconThemeData(color: Colors.white, size: 36),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          debugPrint("Menu Pressed");
                        },
                        icon: const Icon(Icons.menu)),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ReservaQuadraScreen()));
                        },
                        icon: const Icon(Icons.sports_soccer_outlined)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeMembro2()));
                        },
                        icon: const Icon(Icons.schedule_outlined)),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeMembro()));
                        },
                        icon: const Icon(Icons.person_outline,)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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