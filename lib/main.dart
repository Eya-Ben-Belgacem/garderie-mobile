import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() => runApp(const MaGarderieApp());

class MaGarderieApp extends StatelessWidget {
  const MaGarderieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma Garderie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF5B9BE8),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}