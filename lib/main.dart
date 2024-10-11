import 'package:flutter/material.dart';
import 'package:sysale/bemvindos.dart';
import 'package:sysale/_cadastrar.dart';
import 'package:sysale/esqueceuSenha.dart';
import 'package:sysale/home.dart';
import 'package:sysale/splashscreen_abertura.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: MySplashScreen(),
    );
  }
}
