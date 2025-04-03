import 'package:clube/theme/theme.dart';
import 'package:clube/ui/pages/LoginPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clube',
      theme: MaterialTheme(TextTheme()).light(),
      home: LoginPage(),
    );
  }
}


