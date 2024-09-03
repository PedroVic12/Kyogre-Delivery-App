import 'package:flutter/material.dart';

class ColorsTheme {
  // Paleta de cores para o tema claro
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    hintColor: Colors.amber,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
    ),
  );

  // Paleta de cores para o tema escuro
  static final darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    hintColor: Colors.amber,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
    ),
  );
}
