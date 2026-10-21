import 'dart:async';

import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  // Couleurs utilisées lettre par lettre pour le nom de l'application
  static const List<Color> _couleursLettres = [
    Color(0xFFFF7A6B),
    Color(0xFFFFB347),
    Color(0xFF6CC56F),
    Color(0xFF5B9BE8),
    Color(0xFFE56BB0),
  ];

  @override
  void initState() {
    super.initState();
    // Après 3 secondes : transition en fondu vers la page principale
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Découpe un texte en lettres, chacune avec sa couleur
  List<TextSpan> _titreColore(String texte) {
    final spans = <TextSpan>[];
    for (int i = 0; i < texte.length; i++) {
      spans.add(
        TextSpan(
          text: texte[i],
          style: TextStyle(color: _couleursLettres[i % _couleursLettres.length]),
        ),
      );
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCFA),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Décor : cercles pastel en arrière-plan
          const Positioned(top: -60, right: -60, child: _Cercle(taille: 200, couleur: Color(0xFFFFF1CC))),
          const Positioned(top: 150, left: -35, child: _Cercle(taille: 90, couleur: Color(0xFFFFE0E8))),
          const Positioned(bottom: -80, left: -60, child: _Cercle(taille: 240, couleur: Color(0xFFD9ECFF))),
          const Positioned(bottom: 90, right: -30, child: _Cercle(taille: 100, couleur: Color(0xFFDDF5E3))),

          // Contenu : apparition avec fondu et léger effet de rebond
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutBack,
              builder: (context, value, child) => Opacity(
                opacity: value.clamp(0.0, 1.0).toDouble(),
                child: Transform.scale(scale: 0.8 + 0.2 * value, child: child),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 18,
                children: [
                  // Image d'accueil dans un cadre arrondi avec ombre
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.asset('assets/images/splash.png', width: 280),
                    ),
                  ),
                  // Nom de l'application, chaque lettre dans une couleur
                  Text.rich(
                    TextSpan(children: _titreColore('Ma Garderie')),
                    style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Bienvenue ❤️',
                    style: TextStyle(fontSize: 20, letterSpacing: 2, color: Color(0xFF2F4B7C)),
                  ),
                  const SizedBox(height: 4),
                  const CircularProgressIndicator(strokeWidth: 3, color: Color(0xFFFF7A6B)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Petit widget réutilisable : un cercle de couleur
class _Cercle extends StatelessWidget {
  const _Cercle({required this.taille, required this.couleur});

  final double taille;
  final Color couleur;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: taille,
      height: taille,
      decoration: BoxDecoration(color: couleur, shape: BoxShape.circle),
    );
  }
}