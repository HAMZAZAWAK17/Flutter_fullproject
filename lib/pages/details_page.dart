import 'package:flutter/material.dart';

// Classe pour les arguments de la page de détails
class DetailsArguments {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  DetailsArguments({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });
}

class DetailsPage extends StatelessWidget {
  // Méthode 1: Recevoir les arguments via le constructeur
  final DetailsArguments? arguments;

  const DetailsPage({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    // Méthode 2: Récupérer les arguments depuis ModalRoute si non passés via constructeur
    final args = arguments ?? 
                 ModalRoute.of(context)!.settings.arguments as DetailsArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        backgroundColor: args.color,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              args.color.withOpacity(0.3),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icône animée
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: args.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: args.color.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    args.icon,
                    size: 100,
                    color: args.color,
                  ),
                ),
                const SizedBox(height: 40),
                
                // Titre
                Text(
                  args.title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: args.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                
                // Description
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      args.description,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                
                // Bouton de retour
                ElevatedButton.icon(
                  onPressed: () {
                    // Retour à la page précédente avec des données (optionnel)
                    Navigator.pop(context, 'Données de retour');
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Retour'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: args.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
