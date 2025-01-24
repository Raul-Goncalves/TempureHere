import 'package:flutter/material.dart';
import 'package:tempurehere/features/weather/data/services/weather_service.dart';
import 'package:tempurehere/features/weather/presentation/widgets/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _weatherService.fetchWeatherService(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.blueAccent));
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
            print(weatherData);
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
              )),
            );
          } else {
            return const Center(child: Text('Nenhum dado disponível'));
          }
        },
      ),
    );
  }
}
