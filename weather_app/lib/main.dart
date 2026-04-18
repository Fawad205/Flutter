import 'package:flutter/material.dart';
import 'weather_model.dart';
import 'weather_service.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primaryColor: Colors.black),
      home: const WeatherAppScreen(),
    );
  }
}

class WeatherAppScreen extends StatefulWidget {
  const WeatherAppScreen({super.key});

  @override
  State<WeatherAppScreen> createState() => _WeatherAppScreenState();
}

class _WeatherAppScreenState extends State<WeatherAppScreen> {
  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  // Check permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

  final WeatherService _weatherServices = WeatherService();
  Future<Weather>? _weatherFuture;

  void getWeather() async {
  try {
    final position = await _determinePosition();

    setState(() {
      _weatherFuture = _weatherServices.fetchWeather(
        position.latitude,
        position.longitude,
      );
    });
  } catch (e) {
    print(e);
  }
}

  void _refreshWeather() {
    getWeather();
  }

 @override
void initState() {
  super.initState();
  getWeather();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Weather'),
        actions: [
          IconButton(
            onPressed: _refreshWeather,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ElevatedButton(
  onPressed: getWeather,
  child: const Text('Get Current Location Weather'),
),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: getWeather,
                  child: const Text('Get Weather'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: _weatherFuture == null
                  ? const Text('No data available')
                  : FutureBuilder<Weather>(
                      future: _weatherFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error} ');
                        } else if (snapshot.hasData) {
                          final Weather = snapshot.data!;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Weather.cityName,
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                               Image.network(
      'https://openweathermap.org/img/wn/${Weather.icon}@2x.png',
    ),

    const SizedBox(height: 10),
                              
                              Text(
                                '${Weather.temperature.toStringAsFixed(1)}°C',
                                style: const TextStyle(fontSize: 60),
                              ),
                              Text(
                                Weather.description.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.grey),
                              ),
                            ],
                          );
                        }
                        return const Text('No data available');
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}