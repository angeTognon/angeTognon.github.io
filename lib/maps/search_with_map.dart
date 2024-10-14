import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position? _currentPosition;
  double targetLatitude = 9.35798;
  double targetLongitude = 2.63429;
  double radius = 10.0; // 10 mètres
  bool dansEntreprise = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
    });

    // Vérifier si l'utilisateur est dans le rayon
    if (_isWithinRadius(position.latitude, position.longitude)) {
      print('L\'utilisateur est dans le rayon de 10 mètres');
      setState(() {
        dansEntreprise = true;
      });
    } else {
      setState(() {
        dansEntreprise = false;
      });

      print('L\'utilisateur est en dehors du rayon de 10 mètres');
    }
  }

  bool _isWithinRadius(double latitude, double longitude) {
    double distance = _calculateDistance(
        latitude, longitude, targetLatitude, targetLongitude);
    return distance <= radius;
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    double p = 0.017453292519943295;
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dansEntreprise
                ? const Text(
                    "C'est bon. Vous êtes dans l'entreprise",
                    style: TextStyle(fontFamily: 'bold', fontSize: 20),
                  )
                : const Text(
                    "T'es un Menteur",
                    style: TextStyle(fontFamily: 'bold', fontSize: 20),
                  ),
            _currentPosition != null
                ? Text('Latitude: ${_currentPosition!.latitude}')
                : const Text("0"),
            _currentPosition != null
                ? Text('Longitude: ${_currentPosition!.longitude}')
                : const Text("0"),
          ],
        ),
      ),
    );
  }
}
