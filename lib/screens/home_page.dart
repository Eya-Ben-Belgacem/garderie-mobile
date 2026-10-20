import 'package:flutter/material.dart';

// Une activité de la garderie
class Activite {
  const Activite({
    required this.id,
    required this.titre,
    required this.description,
    required this.icone,
  });

  final int id;
  final String titre;
  final String description;
  final String icone; // un emoji
}

// Liste statique déclarée directement dans le code
const List<Activite> activites = [
  Activite(id: 1, titre: 'Dessin et coloriage', description: 'Développement de la créativité', icone: '🎨'),
  Activite(id: 2, titre: 'Jeux éducatifs', description: 'Apprentissage par le jeu', icone: '🧩'),
  Activite(id: 3, titre: 'Musique et chansons', description: 'Éveil musical des enfants', icone: '🎵'),
  Activite(id: 4, titre: 'Lecture de contes', description: 'Découverte des histoires', icone: '📚'),
  Activite(id: 5, titre: 'Activités sportives', description: 'Développement de la motricité', icone: '⚽'),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Garderie'),
        backgroundColor: const Color(0xFF5B9BE8),
        foregroundColor: Colors.white,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF5B9BE8)),
              child: Text(
                'Ma Garderie',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.local_activity),
              title: const Text('Activités'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      // La liste des activités
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: activites.length,
        itemBuilder: (context, index) {
          final a = activites[index];
          return Card(
            child: ListTile(
              leading: Text(a.icone, style: const TextStyle(fontSize: 32)),
              title: Text(a.titre),
              subtitle: Text(a.description),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}