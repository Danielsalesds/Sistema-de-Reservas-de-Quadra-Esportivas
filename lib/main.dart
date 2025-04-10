import 'package:clube/firebase_options.dart';
import 'package:clube/theme/theme.dart';
import 'package:clube/ui/pages/AuthChecker.dart';
import 'package:clube/ui/pages/LoginPage.dart';
import 'package:clube/ui/pages/cadastro_membro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/ConfigureProviders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setLanguageCode("pt");
  final data = await ConfigureProviders.createDependencyTree();
  runApp(MyApp(data: data));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.data});
  final ConfigureProviders data;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: data.providers,
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clube',
        theme: const MaterialTheme(TextTheme()).light(),
        home: AuthChecker(),
      )
    );
  }
}


