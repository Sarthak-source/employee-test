import 'package:flutter/material.dart';
import 'widgets/slpash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employees Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white10,
          centerTitle: false,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)
        ),
      ),
      home: const SplashScreen(), // Show the splash screen first.
    );
  }
}

