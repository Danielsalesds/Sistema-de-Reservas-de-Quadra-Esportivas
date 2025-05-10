import 'package:clube/ui/pages/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/AuthChecker.dart';
import '../pages/HomeMembro2.dart';
import '../pages/ReservaQuadraScreen.dart';
import '../pages/home_membro.dart';

class CustomBottomBar extends StatelessWidget{
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color(0xFF1A1A1A);//F5F5F5
    Color descColor = const Color(0xFF3A3A3A);
    Color baseColor = const Color(0xFF4A90E2);
    Color cardColor2 = const Color(0xFF5A9BD4);
    Color buttonColor = const Color(0xFF2F80ED);

    Color backgroundTela = const Color(0xFFF5F7FA);
    Color uberBlack = const Color(0xFF1C1C1E);
    Color iconeColor = const Color(0xFF1A1A1A);
    
    return BottomAppBar(
      color: baseColor,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AuthChecker()));
                      },
                      icon: Icon(Icons.menu, color: iconeColor,)),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {

                      },
                      icon:  Icon(Icons.sports_soccer_outlined, color: iconeColor,)),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {

                      },
                      icon:  Icon(Icons.schedule_outlined, color: iconeColor,)),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                      },
                      icon:  Icon(Icons.person_outline, color: iconeColor,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}