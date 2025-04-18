import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan ini
import 'package:tugaskelompok/anggota.dart';
import 'package:tugaskelompok/help.dart';
import 'package:tugaskelompok/homepage.dart';
import 'package:tugaskelompok/loginpage.dart';
import 'welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(MainApp(isLoggedIn: isLoggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const WelcomePage(), // Ubah halaman awal menjadi WelcomePage
      home: isLoggedIn ? const HomePage() : const WelcomePage(),
      routes: {
        '/login': (context) =>
            const LoginPage(), // Tambahkan route untuk login page
        '/home': (context) => const HomePage(),
        '/members': (context) => const MembersPage(),
        '/help': (context) => const HelpPage(),
      },
    );
  }
}
