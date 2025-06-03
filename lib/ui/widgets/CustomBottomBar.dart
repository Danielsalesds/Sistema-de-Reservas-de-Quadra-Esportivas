import 'package:clube/ui/pages/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/AppColors.dart';
import '../pages/ListarQuadras.dart';
import '../pages/ListarReservasScreen.dart';

class CustomBottomBar extends StatelessWidget{
  final int ?index;
  const CustomBottomBar({super.key, this.index});


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return BottomAppBar(
      color: colors.cardColor,
      notchMargin: 6.0,
      shape: const CircularNotchedRectangle(),
      // const AutomaticNotchedShape(
      //   RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(5)),
      //   ),
      //   StadiumBorder(),
      // ),
      child: IconTheme(
        data: const IconThemeData(color: Colors.white, size: 36),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //0
                  IconButton(
                      onPressed: () {
                       Navigator.pushNamed(context, '/');
                      },
                      icon: index==0 ? const Icon(Icons.home_outlined, color: Colors.black26 ,)
                          : Icon(Icons.home_outlined, color: colors.iconColor,)
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //1
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ListarQuadras()));
                      },
                      icon: index==1 ? const Icon(Icons.sports_soccer_outlined, color: Colors.black26 ,)
                        : Icon(Icons.sports_soccer_outlined, color: colors.iconColor,)),
                ],
              ),

              Row(
                children: [
                  //2
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ListarReservasScreen()));
                      },
                      icon: index==2 ? const Icon(Icons.schedule_outlined, color: Colors.black26,)
                        : Icon(Icons.schedule_outlined, color: colors.iconColor,)),
                  const SizedBox(
                    width: 10,
                  ),
                  //3
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                      },
                      icon: index==3 ? const Icon(Icons.person_outline, color: Colors.black26,)
                        : Icon(Icons.person_outline, color: colors.iconColor,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}