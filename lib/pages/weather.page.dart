import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  
  var _country = "Maroc";
  var _countryCode = "MA"; // Code pays pour l'API de drapeaux
 
  var _temp; // dynamic
 
  var _pres = 1013;
 
  var _hum = 60;
  String url = "https://api.openweathermap.org/data/2.5/weather?q=Casablanca&appid=f0e8da0d1f63df048b7dbfe55f128ef8";
  String _city = "";

  final List<String> _cities = [
    "Casablanca", "Rabat", "Marrakech", "Tanger", "Agadir", "Paris", "London", "New York", "Tokyo", "Madrid"
  ];

  String _weatherState = "Clear";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.ac_unit, size: 30, color: Colors.white),
            SizedBox(width: 10),
            Text('Weather'),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return _cities.where((String option) {
                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                setState(() {
                  _city = selection;
                });
                _getWeatherData();
              },
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onSubmitted: (value) {
                    setState(() {
                      _city = value;
                    });
                    _getWeatherData();
                  },
                  decoration: InputDecoration(
                    labelText: 'Ville',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.location_city),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                         setState(() {
                           _city = textEditingController.text;
                         });
                         _getWeatherData();
                      },
                    )
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            if (_city.isNotEmpty) ...[
               Card(
                 color: Colors.blue.shade50,
                 child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("City: $_city", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _getWeatherIcon(_weatherState),
                      const SizedBox(height: 10),
                      Text("$_temp °C", style: const TextStyle(fontSize: 40, color: Colors.orange)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              // Affichage du drapeau
                              if (_countryCode.isNotEmpty)
                                Image.network(
                                  "https://flagsapi.com/$_countryCode/flat/64.png", 
                                  height: 50,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.public, size: 50, color: Colors.blueAccent);
                                  },
                                )
                              else 
                                const Icon(Icons.public, size: 50, color: Colors.blueAccent),

                              const Text("Pays"),
                              Text(_country, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.compress, color: Colors.blue),
                              const Text("Pression"),
                              Text("$_pres hPa", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.water_drop, color: Colors.blueAccent),
                              const Text("Humidité"),
                              Text("$_hum %", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
               )
            ]
          ],
        ),
      ),
    );
  }

  // Méthode pour obtenir l'icône selon l'état de la météo
  Widget _getWeatherIcon(String state) {
    switch (state) {
      case 'Clear':
        return const Icon(Icons.wb_sunny, size: 80, color: Colors.orange);
      case 'Clouds':
        return const Icon(Icons.cloud, size: 80, color: Colors.grey);
      case 'Rain':
        return const Icon(Icons.beach_access, size: 80, color: Colors.blue);
      case 'Snow':
        return const Icon(Icons.ac_unit, size: 80, color: Colors.lightBlue);
      default:
        return const Icon(Icons.wb_cloudy, size: 80, color: Colors.blueGrey);
    }
  }

  // Méthode simple pour récupérer les données météo
  void _getWeatherData() {
    String searchQuery = _city;
    // Logique spéciale pour Al-Quds
    if (_city.toLowerCase() == 'al-quds' || _city.toLowerCase() == 'le qods') {
      searchQuery = 'Jerusalem';
    }

    url = "https://api.openweathermap.org/data/2.5/weather?q=$searchQuery&appid=f0e8da0d1f63df048b7dbfe55f128ef8";
    http.get(Uri.parse(url)).then((response) { 
      setState(() {
        var weatherData = json.decode(response.body);
        print(weatherData); // Retour dans la console
        
        // Mise à jour de l'interface
        _country = weatherData['sys']['country'];
        _countryCode = weatherData['sys']['country']; // Récupération du code pays

        // Override manuel pour des raisons politiques/préférences utilisateur
        if (_city.toLowerCase() == 'dakhla') {
           _country = 'Maroc';
           _countryCode = 'MA';
        }
        if (_city.toLowerCase() == 'al-quds' || _city.toLowerCase() == 'le qods' || weatherData['name'].toString().toLowerCase() == 'jerusalem') {
           _country = 'Palestine';
           _countryCode = 'PS';
           if (_city.toLowerCase() == 'al-quds' || _city.toLowerCase() == 'le qods') {
             // Garder le nom affiché comme demandé
           } else {
             // Si ça vient de "Jerusalem", on peut vouloir adapter, mais ici on garde la logique simple
           }
        }
        
        // Conversion basique de Kelvin (par défaut) vers Celsius
        _temp = (weatherData['main']['temp'] - 273.15).toInt(); 
        _pres = weatherData['main']['pressure'];
        _hum = weatherData['main']['humidity'];
        _weatherState = weatherData['weather'][0]['main'];
      });
    }).catchError((arr) {
      print(arr);
    });
  }
}