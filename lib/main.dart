import 'package:flutter/material.dart';
import 'login_page.dart'; // Impor login_page.dart
import 'home_page.dart'; // Impor home_page.dart (untuk navigasi nanti)
import 'register_page.dart'; // Impor register_page.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Klinik Hewan',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Anda bisa ganti warnanya
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(), // Mulai dengan LoginPage
      // Anda bisa menambahkan routes di sini untuk navigasi
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(), // Tambahkan route ini
      },
    );
  }
}

