import 'package:clube/services/AuthService.dart';
import 'package:clube/ui/pages/AuthChecker.dart';
import 'package:clube/ui/pages/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const CustomAppBar({super.key, required this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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

    return AppBar(
      backgroundColor: baseColor,
      title: Text(title, style: TextStyle(color:textColor,),),
      flexibleSpace: Container(
        decoration:  BoxDecoration(
            gradient: LinearGradient(
              colors: [baseColor,baseColor],
              stops: [0, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
      ),
      actions: [
        IconButton(
            onPressed:() async {
              final auth = Provider.of<AuthService>(context,listen:false);
              try{
                await auth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const AuthChecker()));
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()))
                );
              }
            },
            icon: const Icon(Icons.logout),
            color: iconeColor)
      ],
    );
  }
}
