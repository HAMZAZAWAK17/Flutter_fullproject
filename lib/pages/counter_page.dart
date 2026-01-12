import 'package:flutter/material.dart';
import 'message_page.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int compteur = 0;

  void incrementer() {
    setState(() {
      compteur++;
    });
  }

  void decrementer() {
    setState(() {
      compteur--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projet 2 : Compteur'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Le compteur est à :',
            ),
            Text(
              '$compteur',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            
            // Bouton pour envoyer le compteur à une autre page
            ElevatedButton.icon(
              onPressed: () {
                // Navigation vers MessagePage avec passage de données
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagePage(
                      msg: 'Bonjour!!!',
                      compteur: compteur,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.send),
              label: const Text('Envoyer à une autre page'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: incrementer,
            tooltip: 'Incrémenter',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: decrementer,
            tooltip: 'Décrémenter',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

