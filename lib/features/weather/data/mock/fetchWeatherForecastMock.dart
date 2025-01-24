import 'dart:math';

Future<Map<String, dynamic>> fetchWeatherForecastMock() async {
  final random = Random();
  final conditions = ['céu limpo', 'nublado', 'chuva moderada', 'chuva forte', 'neve'];

  return {
    'daily': List.generate(3, (index) {
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