import 'package:flutter/material.dart';
import 'package:tugaskelompok/anggota.dart';
import 'package:tugaskelompok/help.dart';
import 'homepage.dart';
import 'loginpage.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/members': (context) => const MembersPage(),
        '/help': (context) => const HelpPage(),
      },
    );
  }
}


