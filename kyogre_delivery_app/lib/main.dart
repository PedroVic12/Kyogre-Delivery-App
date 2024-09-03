import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_delivery_app/app/pages/DashBoard/DashboardTemplate.dart';
import 'package:kyogre_delivery_app/firebase_options.dart';
import 'package:macos_ui/macos_ui.dart';

void main() async {
  //flutter run –dart-define-from-files=.env

  //   //Gemini.init(apiKey: const String.fromEnvironment('chave_key'));
  //   Gemini.init(apiKey: "AIzaSyBuoUQpUlhv3mAyDipxE519zUwN9B_u1XE");
  //   print("C3po conectado!");

  //   final bot = Gemini.instance;
  //   bot.listModels().then((models) {
  //     print('\n\nModelos Disponiveis: $models');
  //   });
  // }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      debugShowCheckedModeBanner: false,
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      initialRoute: "/",
      routes: {
        '/': (context) => DashboardTemplate(),
        //'/home': (context) => PortifolioPage(),
      },
    );
  }
}
