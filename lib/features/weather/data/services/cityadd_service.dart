import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class cityaddService {
  static final cityaddService _instance = cityaddService._internal();

  factory cityaddService() {
    return _instance;
  }

  cityaddService._internal();

  final List<Map<String, dynamic>> _cityWeatherData = [];

  Future<void> addCityWeatherData({
    required String city,
    required String country,
    required double temp,
    required String description,
    required double tempMin,
    required double tempMax,
  }) async {
    final cityData = {
      'city': city,
      'country': country,
      'temp': temp,
      'description': description,
      'temp_min': tempMin,
      'temp_max': tempMax,
    };
    _cityWeatherData.add(cityData);
    await _saveStorage();
  }

  List<Map<String, dynamic>> getCityWeatherData() {
    return _cityWeatherData;
  }

  Future<void> removeCityWeatherData(String city) async {
    _cityWeatherData.removeWhere((data) => data['city'] == city);
    await _saveStorage();
  }

  Future<void> loadCityWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('cityWeatherData');

    if (storedData != null) {
      final List<dynamic> decoded = jsonDecode(storedData);
      _cityWeatherData.clear();
      _cityWeatherData.addAll(decoded.cast<Map<String, dynamic>>());
    }
  }

  Future<void> _saveStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(_cityWeatherData);
    await prefs.setString('cityWeatherData', jsonData);
  }
}
