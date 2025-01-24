import 'package:flutter/material.dart';
import 'package:tempurehere/features/weather/data/services/cityadd_service.dart';
import 'package:tempurehere/features/weather/data/services/weather_service.dart';

import '../widgets/weather_card.dart';

class AddCityWeatherScreen extends StatefulWidget {
  const AddCityWeatherScreen({super.key});

  @override
  State<AddCityWeatherScreen> createState() => _AddCityWeatherScreenState();
}

class _AddCityWeatherScreenState extends State<AddCityWeatherScreen> {
  final cityaddService _cityAddService = cityaddService();
  final WeatherService _weatherService = WeatherService();
  final TextEditingController searchCity = TextEditingController();

  List<Map<String, dynamic>> cityList = [];
  Map<String, dynamic>? weatherData;
  String? errorMessage;

  bool searchCities = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: searchCities
                ? FutureBuilder<Map<String, dynamic>>(
                    future: _weatherService.fetchWeatherService(
                        city: searchCity.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                                color: Colors.blueAccent));
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Erro ao buscar dados. Tente novamente!'),
                              Icon(Icons.error),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final weatherData = snapshot.data!;
                        return Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  WeatherCardNameCity(
                                    city: weatherData['city'],
                                    country: weatherData['country'],
                                  ),
                                  WeatherCard(
                                    temperature: (weatherData['temp'] as num).toDouble().toStringAsFixed(1),
                                    description: weatherData['description'],
                                    tempmin: (weatherData['temp_min'] as num).toDouble().toStringAsFixed(1),
                                    tempmax: (weatherData['temp_max'] as num).toDouble().toStringAsFixed(1),
                                  ),
                                  WeatherCardNextDays(),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                            child: Text('Nenhum dado disponível'));
                      }
                    },
                  )
                : Card(
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Quer saber o clima hoje? Confira aqui!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: searchCity,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Pesquise uma cidade',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: 'Ex: Covilhã',
                              hintStyle: TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                searchCities = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Pesquisar'),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
      floatingActionButton: searchCities
          ? FutureBuilder<Map<String, dynamic>>(
              future:
                  _weatherService.fetchWeatherService(city: searchCity.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        final weatherData = snapshot.data!;

                        _cityAddService.addCityWeatherData(
                          city: weatherData['city'],
                          country: weatherData['country'],
                          temp: weatherData['temp'],
                          tempMin: weatherData['temp_min'],
                          tempMax: weatherData['temp_max'],
                          description: weatherData['description'],
                        );

                        setState(() {
                          print('Cidade: ${weatherData['city']}');
                          print('País: ${weatherData['country']}');
                          print('Temperatura: ${weatherData['temp']}°C');
                          searchCities = false;
                          searchCity.clear();
                        });
                      });
                    },
                    child:
                        Icon(Icons.bookmark_add_outlined, color: Colors.white),
                    backgroundColor: Colors.blueAccent,
                    tooltip: 'Voltar ao início',
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            )
          : null,
    );
  }
}
