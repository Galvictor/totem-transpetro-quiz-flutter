import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Jogo Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // Define as rotas da aplicação
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/intro': (context) => const IntroPage(),
      },
    );
  }
}
