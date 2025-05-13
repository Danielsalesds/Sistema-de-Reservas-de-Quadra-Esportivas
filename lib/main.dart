import 'package:clube/firebase_options.dart';
import 'package:clube/services/ThemeService.dart';
import 'package:clube/theme/theme.dart';
import 'package:clube/ui/pages/AuthChecker.dart';
import 'package:clube/ui/pages/CadastroMembro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/ConfigureProviders.dart';
import 'package:overlay_support/overlay_support.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setLanguageCode("pt");
  final data = await ConfigureProviders.createDependencyTree();
  runApp(
    OverlaySupport.global(
      child: MyApp(data: data), // Aqui você envolve seu app normal
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.data});
  final ConfigureProviders data;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    bool isDark = await ThemeService.getTheme();
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }
  void _toggleTheme(bool isDark){
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: widget.data.providers,
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clube',
        theme: MaterialTheme(const TextTheme()).light(),
        darkTheme: MaterialTheme(const TextTheme()).dark(),
        themeMode: _themeMode,
        initialRoute: '/',
        routes: {
          '/': (context) => AuthChecker(onThemeChanged: _toggleTheme),
          '/CadastroMembro': (context) => const CadastroMembro(),
        },
        //home: AuthChecker(),
      )
    );
  }
}


