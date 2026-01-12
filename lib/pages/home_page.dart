import 'package:flutter/material.dart';
import 'stateless_page.dart';
import 'counter_page.dart';
import 'calculator_page.dart';
import 'image_page.dart';
import 'details_page.dart';
import 'ui_widgets_page.dart';
import 'students.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Projets Flutter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StatelessPage()),
                );
              },
              child: const Text('Projet 1: Formulaire'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CounterPage()),
                );
              },
              child: const Text('Projet 2: Compteur'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalculatorPage()),
                );
              },
              child: const Text('Projet 3: Calculatrice'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImagePage()),
                );
              },
              child: const Text('Projet 4: Images'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UiWidgetsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('UI Widgets'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Weather App'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Gestion des étudiants'),
            ),
            const SizedBox(height: 40),
            
            // Séparateur pour les exemples de routage dynamique
            const Divider(thickness: 2),
            const Text(
              'Routage Dynamique avec Données',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            
            // Méthode 1: Navigation avec arguments via constructeur
            ElevatedButton.icon(
              onPressed: () {
                // Navigation avec passage de données via le constructeur
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      arguments: DetailsArguments(
                        title: 'Flutter',
                        description: 'Navigation avec constructeur - Les données sont passées directement au constructeur de la page.',
                        color: Colors.blue,
                        icon: Icons.flutter_dash,
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.send),
              label: const Text('Navigation avec Constructeur'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            
            // Méthode 2: Navigation avec arguments via settings
            ElevatedButton.icon(
              onPressed: () {
                // Navigation avec passage de données via settings.arguments
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailsPage(),
                    settings: RouteSettings(
                      arguments: DetailsArguments(
                        title: 'Dart',
                        description: 'Navigation avec RouteSettings - Les données sont passées via les paramètres de la route.',
                        color: Colors.purple,
                        icon: Icons.code,
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Navigation avec RouteSettings'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            
            // Méthode 3: Navigation nommée avec arguments
            ElevatedButton.icon(
              onPressed: () async {
                // Navigation avec route nommée et récupération du résultat
                final result = await Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: DetailsArguments(
                    title: 'Material Design',
                    description: 'Navigation nommée avec arguments - Utilise les routes définies dans main.dart.',
                    color: Colors.green,
                    icon: Icons.design_services,
                  ),
                );
                
                // Afficher le résultat retourné par la page
                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Retour: $result')),
                  );
                }
              },
              icon: const Icon(Icons.route),
              label: const Text('Navigation avec Route Nommée'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

