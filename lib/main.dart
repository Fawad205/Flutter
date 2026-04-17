import 'package:flutter/material.dart';
import 'weather_model.dart';
import 'weather_service.dart';

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
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();

  final WeatherService _weatherServices = WeatherService();
  Future<Weather>? _weatherFuture;

  void getWeather() {
    double? lat = double.tryParse(latController.text);
    double? lon = double.tryParse(lonController.text);

    if (lat == null || lon == null) {
      return;
    }

    setState(() {
      _weatherFuture = _weatherServices.fetchWeather(lat, lon);
    });
  }

  void _refreshWeather() {
    getWeather();
  }

  @override
  void dispose() {
    latController.dispose();
    lonController.dispose();
    super.dispose();
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
                TextField(
                  controller: latController,
                  decoration: const InputDecoration(
                    labelText: 'Latitude',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: lonController,
                  decoration: const InputDecoration(
                    labelText: 'Longitude',
                    border: OutlineInputBorder(),
                  ),
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