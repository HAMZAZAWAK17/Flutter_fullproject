import 'package:flutter/material.dart';

class StatelessPage extends StatefulWidget {
  const StatelessPage({super.key});

  @override
  State<StatelessPage> createState() => _StatelessPageState();
}

class _StatelessPageState extends State<StatelessPage> {
  final TextEditingController _controller = TextEditingController();
  String message = '';

  void afficherMessage() {
    setState(() {
      if (_controller.text.isEmpty) {
        message = 'Veuillez entrer votre nom 👇';
      } else {
        message = 'Bonjour ${_controller.text} 👋';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projet 1 : Formulaire'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Entrez votre nom',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: afficherMessage,
              child: const Text('Afficher'),
            ),
            const SizedBox(height: 40),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}

