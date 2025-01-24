import 'package:flutter/material.dart';
import 'features/weather/data/models/home.dart';

void main(){
  runApp(const TempureHere());
}

class TempureHere extends StatelessWidget {
  const TempureHere({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}