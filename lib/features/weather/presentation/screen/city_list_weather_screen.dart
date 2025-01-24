import 'package:flutter/material.dart';
import 'package:tempurehere/core/theme/app_fonts.dart';
import '../../data/services/cityadd_service.dart';

class CityListWeatherScreen extends StatefulWidget {
  const CityListWeatherScreen({super.key});

  @override
  State<CityListWeatherScreen> createState() => _CityListWeatherScreenState();
}

class _CityListWeatherScreenState extends State<CityListWeatherScreen> {
  final cityaddService _cityAddService = cityaddService();
  List<Map<String, dynamic>> savedCities = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCities();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _cityAddService.loadCityWeatherData();
    setState(() {
      savedCities = _cityAddService.getCityWeatherData();
    });
  }

  Future<void> _loadSavedCities() async {
    setState(() {
      savedCities = _cityAddService.getCityWeatherData();
    });
  }

  void _removeCity(String cityName) {
    _cityAddService.removeCityWeatherData(cityName);
    _loadSavedCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title:
            Center(child: Text('Cidades Preferidas', style: appFonts.custom())),
      ),
      body: RefreshIndicator(
        onRefresh: _loadSavedCities,
        child: savedCities.isEmpty
            ? const Center(child: Text('Nenhuma cidade salva!'))
            : ListView.builder(
                itemCount: savedCities.length,
                itemBuilder: (context, index) {
                  final city = savedCities[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    color: Colors.blueAccent,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${city['city']}, ${city['country']}',
                                    style: appFonts.custom(),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    '${city['temp'].toStringAsFixed(1)}°',
                                    style: TextStyle(
                                      fontSize: 55,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              SizedBox(height: 45),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${city['description']}',
                                      style: appFonts.custom()),
                                  Text(
                                      '${city['temp_min'].toStringAsFixed(1)}º/${city['temp_max'].toStringAsFixed(1)}º',
                                      style: appFonts.custom())
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _removeCity(city['city']);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
