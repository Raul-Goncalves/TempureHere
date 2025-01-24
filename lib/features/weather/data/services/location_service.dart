import 'package:geolocator/geolocator.dart';

class locationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception(
          'O serviço de localização está desativado. Por favor ative ele para poder usar.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('A permissão de localização foi negada');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Permissão de localização foi negada permanentemente. Mude nas configurações do aplicativo.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
