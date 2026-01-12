import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String resultat = '';

  void calculer(String operation) {
    setState(() {
      double? num1 = double.tryParse(_num1Controller.text);
      double? num2 = double.tryParse(_num2Controller.text);

      if (num1 == null || num2 == null) {
        resultat = 'Erreur';
        return;
      }

      double resultValue = 0;
      switch (operation) {
        case '+':
          resultValue = num1 + num2;
          break;
        case '-':
          resultValue = num1 - num2;
          break;
        case '×':
          resultValue = num1 * num2;
          break;
        case '÷':
          resultValue = num2 != 0 ? num1 / num2 : double.infinity;
          break;
      }
      
      if (resultValue.isInfinite) {
        resultat = 'Erreur';
      } else {
        resultat = resultValue.toStringAsFixed(2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projet 3 : Calculatrice'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Premier nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Deuxième nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => calculer('+'), child: const Text('+')),
                ElevatedButton(onPressed: () => calculer('-'), child: const Text('-')),
                ElevatedButton(onPressed: () => calculer('×'), child: const Text('×')),
                ElevatedButton(onPressed: () => calculer('÷'), child: const Text('÷')),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'Résultat : $resultat',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}

