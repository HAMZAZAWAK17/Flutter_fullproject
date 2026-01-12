import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  // Liste des étudiants (données initiales)
  List<Map<String, String>> students = [
    {"nom": "Alaoui", "prenom": "Ali"},
    {"nom": "Mansouri", "prenom": "Sara"},
    {"nom": "Benani", "prenom": "Omar"},
  ];

  // Contrôleurs pour les champs de texte
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();

  // Fonction pour ajouter un étudiant
  void _addStudent() {
    _nomController.clear();
    _prenomController.clear();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Ajouter un étudiant"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                students.add({
                  "nom": _nomController.text,
                  "prenom": _prenomController.text,
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Ajouter"),
          ),
        ],
      ),
    );
  }

  // Fonction pour modifier un étudiant
  void _editStudent(int index) {
    _nomController.text = students[index]["nom"]!;
    _prenomController.text = students[index]["prenom"]!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Modifier l'étudiant"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                students[index] = {
                  "nom": _nomController.text,
                  "prenom": _prenomController.text,
                };
              });
              Navigator.pop(context);
            },
            child: const Text("Sauvegarder"),
          ),
        ],
      ),
    );
  }

  // Fonction pour supprimer un étudiant
  void _deleteStudent(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Supprimer"),
        content: Text("Voulez-vous vraiment supprimer ${students[index]['prenom']} ${students[index]['nom']} ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Non"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                students.removeAt(index);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Oui", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des étudiants"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Bouton Ajouter en haut
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _addStudent,
              icon: const Icon(Icons.add),
              label: const Text("Ajouter un étudiant"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          
          // Liste des étudiants
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(students[index]["nom"]![0].toUpperCase()),
                    ),
                    title: Text("${students[index]["nom"]} ${students[index]["prenom"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editStudent(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteStudent(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
