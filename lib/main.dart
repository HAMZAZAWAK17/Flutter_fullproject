import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/image_page.dart';
import 'pages/calculator_page.dart';
import 'pages/counter_page.dart';
import 'pages/stateless_page.dart';
import 'pages/details_page.dart';
import 'pages/weather.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mes 3 Projets Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Définition des routes nommées
      routes: {
        "/": (context) => const HomePage(),
        "/image": (context) => const ImagePage(),
        "/calculator": (context) => const CalculatorPage(),
        "/counter": (context) => const CounterPage(),
        "/stateless": (context) => const StatelessPage(),
        "/details": (context) => const DetailsPage(),
        "/weather": (context) => const WeatherPage(),
      },
      initialRoute: "/",
    );
  }
}
