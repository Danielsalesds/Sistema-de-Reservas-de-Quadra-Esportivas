import 'package:clube/ui/pages/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/AppColors.dart';

class CustomBottomBar extends StatelessWidget{
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return BottomAppBar(
      color: colors.cardColor,
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
                       Navigator.pushNamed(context, '/');
                      },
                      icon: Icon(Icons.menu, color: colors.iconColor,)),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {

                      },
                      icon:  Icon(Icons.sports_soccer_outlined, color: colors.iconColor,)),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {

                      },
                      icon:  Icon(Icons.schedule_outlined, color: colors.iconColor,)),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                      },
                      icon:  Icon(Icons.person_outline, color: colors.iconColor,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}