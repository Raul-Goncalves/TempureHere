import 'package:flutter/material.dart';

import '../../presentation/screen/add_city_weather_screen.dart';
import '../../presentation/screen/city_list_weather_screen.dart';
import '../../presentation/screen/weather_screen.dart';
import '../../presentation/widgets/bottombar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    WeatherScreen(),
    AddCityWeatherScreen(),
    CityListWeatherScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Bottombar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}