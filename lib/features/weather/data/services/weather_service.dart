import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:tempurehere/features/weather/data/services/location_service.dart';

class WeatherService {
  final String KeyApi = 'SUA API';
  final String Baseurl = 'https://api.openweathermap.org/data/2.5/weather/';

  Future<Map<String, dynamic>> fetchWeatherService({String? city}) async {
    Uri url;

    if (city != null && city.isNotEmpty) {
      url = Uri.parse('$Baseurl?q=$city&appid=$KeyApi&units=metric&lang=pt_br');
    } else {
      final locationServices = locationService();
      final position = await locationServices.getCurrentLocation();

      url = Uri.parse(
          '$Baseurl?lat=${position.latitude}&lon=${position.longitude}&appid=$KeyApi&units=metric&lang=pt_br');
    }

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final WheatherDetails = {
          'city': data['name'],
          'country': data['sys']['country'],
          'temp': data['main']['temp'],
          'temp_min': data['main']['temp_min'],
          'temp_max': data['main']['temp_max'],
          'description': data['weather'][0]['description'],
        };

        return WheatherDetails;
      } else {
        throw Exception('Erro ao buscar o clima: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherForecastMock() async {
    final random = Random();
    final conditions = ['céu limpo', 'nublado', 'chuva moderada', 'chuva forte', 'neve'];

    return {
      'daily': List.generate(8, (index) {
        final date = DateTime.now().add(Duration(days: index));
        final tempMin = 15 + random.nextDouble() * 10;
        final tempMax = tempMin + random.nextDouble() * 5;
        final condition = conditions[random.nextInt(conditions.length)];

        return {
          'dt': date.millisecondsSinceEpoch ~/ 1000,
          'temp': {'min': tempMin, 'max': tempMax},
          'weather': [
            {'description': condition, 'icon': '01d'}
          ]
        };
      })
    };
  }
}
