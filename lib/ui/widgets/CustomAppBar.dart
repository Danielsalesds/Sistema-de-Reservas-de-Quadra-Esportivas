import 'package:clube/services/AuthService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/AppColors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return AppBar(
      backgroundColor: colors.cardColor,
      title: Text(widget.title, style: TextStyle(color:colors.textColor,),),
      flexibleSpace: Container(
        decoration:  BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.cardColor,colors.cardColor],
              stops: const [0, 1],
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
                Navigator.pushNamed(context, '/');
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()))
                );
              }
            },
            icon: const Icon(Icons.logout),
            color: colors.iconColor
        )
      ],
    );
  }
}
