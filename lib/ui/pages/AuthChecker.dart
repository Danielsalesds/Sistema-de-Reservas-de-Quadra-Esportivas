import 'package:clube/ui/pages/HomeAdmin.dart';
import 'package:clube/ui/pages/home_membro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginOrRegisterPage.dart';

class AuthChecker extends StatelessWidget{
  const AuthChecker({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) =>
          snapshot.hasData ?  HomeAdmin() : const LoginOrRegisterPage(),
        ),
      );
    }
}