import 'package:flutter/material.dart';

void main() => runApp(const MaGarderieApp());

class MaGarderieApp extends StatelessWidget {
  const MaGarderieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma Garderie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF5B9BE8)),
      home: const Scaffold(
        body: Center(
          child: Text('Ma Garderie', style: TextStyle(fontSize: 28)),
        ),
      ),
    );
  }
}
