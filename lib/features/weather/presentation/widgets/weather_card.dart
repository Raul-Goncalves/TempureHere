import 'package:flutter/material.dart';
import 'package:tempurehere/core/theme/app_fonts.dart';
import '../../data/mock/fetchWeatherForecastMock.dart';
import '../../data/services/weather_service.dart';

String getWeatherImageCase(String description) {
  switch (description.trim().toLowerCase()) {
    case 'céu limpo':
      return 'assets/image/sol.png';
    case 'nuvens dispersas':
      return 'assets/image/sol_nuvem.png';
    case 'nublado':
      return 'assets/image/nublado.png';
    case 'chuva fracca':
      return 'assets/image/sol_chuva.png';
    case 'chuva moderado':
      return 'assets/image/chuva.png';
    case 'chuva forte':
      return 'assets/image/chuva.png';
    case 'trovoada':
      return 'assets/image/chuva_trovao.png';
    case 'neve':
      return 'assets/image/neve.png';
    case 'névoa':
      return 'assets/image/nublado.png';
    default:
      return 'assets/image/sol.png'; // Default image
  }
}

// WeatherNameCity

class WeatherCardNameCity extends StatefulWidget {
  final String city;
  final String country;

  const WeatherCardNameCity(
      {super.key, required this.city, required this.country});

  @override
  State<WeatherCardNameCity> createState() => _WeatherCardNameCityState();
}

class _WeatherCardNameCityState extends State<WeatherCardNameCity> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.height,
              child: Text(
                '${widget.city}, ${widget.country}',
                style: appFonts.normalText(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//WeatherCardCityNow

class WeatherCard extends StatefulWidget {
  final String temperature;
  final String description;
  final String tempmin;
  final String tempmax;

  const WeatherCard(
      {super.key,
      required this.temperature,
      required this.description,
      required this.tempmin,
      required this.tempmax});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    String imagePath = getWeatherImageCase(widget.description);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 250, width: 250),
            SizedBox(height: 50),
            Row(
              children: [
                Text('${widget.temperature}º',
                    style: appFonts.titleTemp(color: Colors.black)),
                Text('\n${widget.description}',
                    style: appFonts.normalText(color: Colors.black)),
                Spacer(),
                Text('\n${widget.tempmin}/${widget.tempmax}',
                    style: appFonts.subText(color: Colors.black)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// WeatherCardNextDays

class WeatherCardNextDays extends StatefulWidget {
  const WeatherCardNextDays({Key? key}) : super(key: key);

  @override
  State<WeatherCardNextDays> createState() => _WeatherCardNextDaysState();
}

class _WeatherCardNextDaysState extends State<WeatherCardNextDays> {
  List<Map<String, dynamic>> dailyForecasts = [];

  @override
  void initState() {
    super.initState();
    fetchMockForecast();
  }

  Future<void> fetchMockForecast() async {
    final forecastData = await fetchWeatherForecastMock();
    setState(() {
      dailyForecasts = forecastData['daily'].take(3).toList();
    });
  }

  String getWeatherImage(String description) {
    if (description.contains('céu limpo')) {
      return 'assets/image/sol.png';
    } else if (description.contains('nublado')) {
      return 'assets/image/nublado.png';
    } else if (description.contains('chuva')) {
      return 'assets/image/chuva.png';
    } else if (description.contains('neve')) {
      return 'assets/image/neve.png';
    }
    return 'assets/image/sol.png';
  }

  List<String> _getNextDays() {
    final today = DateTime.now();
    final weekdays = [
      'Domingo',
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado'
    ];

    return List.generate(3, (index) {
      final nextDay = today.add(Duration(days: index));
      return index == 0 ? 'Hoje' : weekdays[nextDay.weekday % 7];
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = _getNextDays();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: dailyForecasts.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: List.generate(dailyForecasts.length, (index) {
            final forecast = dailyForecasts[index];
            final dayName = days[index];
            final imagePath = getWeatherImage(forecast['weather'][0]['description']);
            final tempMin = forecast['temp']['min'];
            final tempMax = forecast['temp']['max'];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Image.asset(
                    imagePath,
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 8),
                  Text(dayName, style: appFonts.subText(color: Colors.black)),
                  const Spacer(),
                  Text('${tempMin.toStringAsFixed(1)}°/${tempMax.toStringAsFixed(1)}°',
                      style: appFonts.subText(color: Colors.black)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}