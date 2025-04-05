import 'package:clube/services/AuthService.dart';
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

    return AppBar(
      title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,),),
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

            onPressed:(){
              final auth = Provider.of<AuthService>(context,listen:false);
              try{
                auth.signOut();
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()))
                );
              }
            },
            icon: const Icon(Icons.logout),
            color: Theme.of(context).colorScheme.onPrimary)
      ],
    );
  }
}
