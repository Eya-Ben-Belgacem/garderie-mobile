import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar avec le titre
      appBar: AppBar(
        title: const Text('Ma Garderie'),
        backgroundColor: const Color(0xFF5B9BE8),
        foregroundColor: Colors.white,
      ),

      // 2. Drawer : menu latéral avec 3 éléments
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

      // 3. Floating Action Button avec l'icône +
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      // 4. Espace destiné à la liste d'activités
      body: const Center(child: Text('Liste des activités ici')),
    );
  }
}