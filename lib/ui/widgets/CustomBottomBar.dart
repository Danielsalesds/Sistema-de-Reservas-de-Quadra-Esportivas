import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/HomeMembro2.dart';
import '../pages/ReservaQuadraScreen.dart';
import '../pages/home_membro.dart';

class CustomBottomBar extends StatelessWidget{
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
    );
  }

}