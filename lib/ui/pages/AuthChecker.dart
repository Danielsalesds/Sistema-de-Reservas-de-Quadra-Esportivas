import 'package:clube/services/FirestoreService.dart';
import 'package:clube/ui/pages/HomeAdmin.dart';
import 'package:clube/ui/pages/home_membro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LoginOrRegisterPage.dart';

class AuthChecker extends StatefulWidget{
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  String? role;
  @override
    @override
    Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context, listen:false);
      return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                future: firestore.getRole(),
                builder: (context, snapshotRole) {
                  if (!snapshotRole.hasData) return const Center(child: CircularProgressIndicator());
                  final role = snapshotRole.data;
                  return role == 'admin' ? HomeAdmin() : HomeMembro();
                },
              );
            } else {
              return const LoginOrRegisterPage();
            }
          }
        ),
      );
    }
}