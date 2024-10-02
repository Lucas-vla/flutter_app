import 'package:exo3/consts.dart';
import 'package:flutter/material.dart';  // Import des widgets et outils Flutter pour créer l'interface utilisateur
import 'package:exo3/services/catapi.dart';  // Import du service CatApi pour récupérer les données des races de chats
import 'package:exo3/models/breed.dart';  // Import du modèle Breed qui représente les races de chats

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // S'assure que les widgets sont bien initialisés avant d'exécuter le reste du code
  await CatApi().breeds();  // Récupère les données des races de chats avant de lancer l'application
  runApp(const MyApp());  // Démarre l'application Flutter
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Races de chat',  // Titre de l'application
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Races de chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final catApi = CatApi();  // Instance de l'API CatApi pour interagir avec les données des races de chats
  final String title;  // Titre de la page d'accueil

  @override
  State<MyHomePage> createState() => _MyHomePageState();  // Crée l'état de la page
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Breed>> _breeds;  // Future qui contiendra la liste des races de chats

  @override
  void initState() {
    super.initState();
    _breeds = widget.catApi.breeds();  // Appel à l'API pour récupérer les races de chats au moment de l'initialisation de l'état
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(widget.title),  // Affiche le titre de la page dans l'AppBar
    ),
    body: Column(
    children: [
    Expanded(
    child: FutureBuilder<List<Breed>>(
    future: _breeds,  // Utilise le Future pour construire l'interface utilisateur lorsque les données sont disponibles
    builder: (context, snapshot) {
    // Gestion des différents états de chargement du Future
    if (snapshot.connectionState == ConnectionState.waiting) {
    // Si les données sont en cours de chargement, afficher un indicateur de progression
    return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    // Si une erreur survient lors du chargement, afficher un message d'erreur
    return const Center(child: Text('Error loading data.'));
    } else if (snapshot.hasData) {
    // Si les données sont disponibles, afficher la liste des races
    final data = snapshot.data!;
    return ListView.builder(
    padding: defaultPadding,
    itemCount: data.length,
    itemBuilder: (context, index) {
    final breed = data[index];  // Récupère la race de chat à l'index actuel
    return Card(
    margin: const EdgeInsets.all(8.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Affiche le nom de la race avec un style personnalisé
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    breed.name,  // Nom de la race de chat
    style: const TextStyle(
    fontSize: 18,  // Taille du texte pour le nom de la race
    ),
    ),
    ),
    // Si la race a une image associée, l'afficher
    if (breed.image != null)
    Container(
    height: 200,
    width: double.infinity,  // L'image prend toute la largeur du conteneur
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),

    ),
      // Affiche l'image provenant de l'URL
      child: Image.network(
        breed.image!.url,  // URL de l'image associée à la race de chat
        fit: BoxFit.cover,  // L'image occupe toute la taille disponible sans déformation
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            // Si l'image est chargée, la retourner directement
            return child;
          }
          // Si l'image est encore en cours de chargement, afficher un CircularProgressIndicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          // Si une erreur survient lors du chargement de l'image, afficher un message d'erreur
          return const Center(
            child: Text('Image not available'),
          );
        },
      ),
    ),
      const SizedBox(height: 10),  // Ajoute un espace vertical après l'image
    ],
    ),
    );
    },
    );
    } else {
      // Si aucune donnée n'est disponible, afficher un message approprié
      return const Center(child: Text('No data available.'));
    }
    },
    ),
    ),
    ],
    ),
    );
  }
}

