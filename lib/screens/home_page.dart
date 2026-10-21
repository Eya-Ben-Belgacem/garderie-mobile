import 'package:flutter/material.dart';

// Couleurs de l'application
const Color couleurPrincipale = Color(0xFF5B9BE8);
const Color couleurFond = Color(0xFFF5F9FF);
const Color couleurTexte = Color(0xFF2F4B7C);

// Une activité de la garderie
class Activite {
  const Activite({
    required this.id,
    required this.titre,
    required this.description,
    required this.icone,
    required this.couleur,
  });

  final int id;
  final String titre;
  final String description;
  final String icone;
  final Color couleur; // couleur pastel derrière l'icône
}

// Liste statique déclarée directement dans le code
const List<Activite> activites = [
  Activite(id: 1, titre: 'Dessin et coloriage', description: 'Développement de la créativité', icone: '🎨', couleur: Color(0xFFFFEBDD)),
  Activite(id: 2, titre: 'Jeux éducatifs', description: 'Apprentissage par le jeu', icone: '🧩', couleur: Color(0xFFDDF5E3)),
  Activite(id: 3, titre: 'Musique et chansons', description: 'Éveil musical des enfants', icone: '🎵', couleur: Color(0xFFFFE0E8)),
  Activite(id: 4, titre: 'Lecture de contes', description: 'Découverte des histoires', icone: '📚', couleur: Color(0xFFDDEBFF)),
  Activite(id: 5, titre: 'Activités sportives', description: 'Développement de la motricité', icone: '⚽', couleur: Color(0xFFEDE3FF)),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // entrée du Drawer sélectionnée (0 = Accueil)

  final List<String> _menu = ['Accueil', 'Activités', 'À propos'];
  final List<IconData> _menuIcons = [
    Icons.home_rounded,
    Icons.local_activity_rounded,
    Icons.info_rounded,
  ];

  // Affiche un message flottant en bas de l'écran
  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: couleurTexte,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: couleurPrincipale,

      // 1. AppBar
      appBar: AppBar(
        title: const Text('Ma Garderie', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: couleurPrincipale,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(backgroundColor: Colors.white, child: Text('🧒')),
          ),
        ],
      ),

      // 2. Drawer
      drawer: _buildDrawer(context),

      // 3. Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMessage('Nouvelle activité'),
        backgroundColor: couleurPrincipale,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),

      // 4. Corps : zone claire aux coins arrondis, par-dessus le fond bleu
      body: Container(
        decoration: const BoxDecoration(
          color: couleurFond,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            const _BonjourCard(),
            Expanded(child: _buildListe()),
          ],
        ),
      ),
    );
  }

  // ---------- LE DRAWER ----------
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // En-tête avec dégradé
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 20, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [couleurPrincipale, Color(0xFF8EC1FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Text('🧸', style: TextStyle(fontSize: 36)),
                ),
                SizedBox(height: 14),
                Text(
                  'Ma Garderie',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('Activités enchantées', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Les 3 entrées du menu
          for (int i = 0; i < _menu.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                leading: Icon(_menuIcons[i]),
                title: Text(_menu[i]),
                selected: _selectedIndex == i,
                selectedColor: couleurPrincipale,
                selectedTileColor: const Color(0xFFE3EEFF),
                onTap: () {
                  setState(() => _selectedIndex = i);
                  Navigator.pop(context);
                  _showMessage(_menu[i]);
                },
              ),
            ),

          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Ma Garderie • version 1.0', style: TextStyle(color: Colors.black38)),
          ),
        ],
      ),
    );
  }

  // ---------- LA LISTE DES ACTIVITÉS ----------
  Widget _buildListe() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
      itemCount: activites.length,
      itemBuilder: (context, index) {
        final a = activites[index];

        // Chaque carte apparaît en glissant vers le haut, l'une après l'autre
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 400 + index * 120),
          curve: Curves.easeOut,
          builder: (context, value, child) => Opacity(
            opacity: value,
            child: Transform.translate(offset: Offset(0, 30 * (1 - value)), child: child),
          ),
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 2,
            shadowColor: couleurPrincipale.withValues(alpha: 0.25),
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              // Tuile colorée avec l'emoji
              leading: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: a.couleur,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(a.icone, style: const TextStyle(fontSize: 28)),
              ),
              title: Text(
                a.titre,
                style: const TextStyle(fontWeight: FontWeight.bold, color: couleurTexte),
              ),
              subtitle: Text(a.description),
              trailing: const Icon(Icons.chevron_right_rounded, color: couleurPrincipale),
              onTap: () => _showMessage(a.titre),
            ),
          ),
        );
      },
    );
  }
}

// ---------- LA CARTE « BONJOUR » ----------
class _BonjourCard extends StatelessWidget {
  const _BonjourCard();

  @override
  Widget build(BuildContext context) {
    // Salutation selon l'heure de la journée
    final heure = DateTime.now().hour;
    final salutation = heure < 18 ? 'BONJOUR !' : 'BONSOIR !';
    final emoji = heure < 18 ? '☀️' : '🌙';

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFE3EEFF), Color(0xFFD3E6FF)]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  salutation,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Quelle activité aujourd'hui ?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: couleurTexte),
                ),
              ],
            ),
          ),
          Text(emoji, style: const TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}