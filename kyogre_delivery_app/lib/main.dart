import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_delivery_app/app/pages/CardapioManager/CardapioManagerPage.dart';
import 'package:kyogre_delivery_app/app/pages/DashBoard/DashboardTemplate.dart';
import 'package:kyogre_delivery_app/app/pages/Home/HomePage.dart';
import 'package:kyogre_delivery_app/app/themes/temas.dart';
import 'package:kyogre_delivery_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ColorsTheme.darkTheme : ColorsTheme.lightTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: "/",
      routes: {
        '/': (context) => HomePage(onThemeChange: (bool value) {
              setState(() {
                _isDarkMode = value;
              });
            }),
        '/dash': (context) => DashboardTemplate(),
        '/CardapioManager': (context) => CardapioManagerPage(),
      },
    );
  }
}
