//MARIA ALEJANDRA PATIÑO AGUILAR
//MI PROYECTO FINAL PREGUNTADOS-TRIVIA

import 'package:flutter/material.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/game_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trivia X',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Orbitron',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/game': (context) => GamePage(categoria: 'Cultura Colombiana'),
      },
    );
  }
}
