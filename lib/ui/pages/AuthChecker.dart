import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clube/services/FirestoreService.dart';
import 'package:clube/ui/pages/HomeAdmin.dart';
import 'package:clube/ui/pages/LoginPage.dart';
import 'package:clube/ui/pages/home_membro.dart';
import 'package:clube/ui/widgets/AletMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LoginOrRegisterPage.dart';
import 'RegisterPage.dart';

class AuthChecker extends StatefulWidget{
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  String? role;
    @override
    Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context, listen:false);
      return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return FutureBuilder(
                future: firestore.getUserData(),
                builder: (context, snapshotUser) {
                  if (!snapshotUser.hasData) return const Center(child: CircularProgressIndicator());
                  final data = snapshotUser.data as Map<String, dynamic>;
                  final tipo = data['tipo'];
                  final ativo = data['ativo'];
                  if(!ativo){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        title: "Acesso Negado",
                        desc:"Seu usuário está inativo. Entre em contato com o administrador",
                        btnOkText: "Ok",
                        btnOkColor: Theme.of(context).colorScheme.primary,
                        btnOkOnPress: () {
                          FirebaseAuth.instance.signOut();
                        },
                        titleTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                        ),
                        descTextStyle: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ).show();
                    });
                    return const Scaffold(
                      body: Center(
                        child: SizedBox(),
                      ),
                    );
                  }
                  return tipo == 'Admin' ? HomeAdmin() : HomeMembro();
                },
              );
            } else {
              return const LoginPage();
            }
          }
        ),
      );
    }
}