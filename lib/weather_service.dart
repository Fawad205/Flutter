import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {

  static const String apiKey = 'e2c6712ae7e7a01796c28866b4da1e12';

  Future<Weather>fetchWeather(double lat , double lon) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
    
 final response = await http.get(url);
    if (response.statusCode == 200) {
      // Parse the JSON data
      final jsonResponse = jsonDecode(response.body);
      return Weather.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

}