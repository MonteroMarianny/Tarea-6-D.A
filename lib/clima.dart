import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  String _city = 'Dominica Republic'; // Ciudad por defecto, puedes cambiarla según tus necesidades
  String _apiKey = 'RDclima'; // Aquí debes colocar tu API key de OpenWeatherMap

  String _weatherDescription = '';
  double _temperature = 0.0;

  Future<void> fetchWeather() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$_city&appid=$_apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _weatherDescription = data['weather'][0]['description'];
        _temperature = (data['main']['temp'] - 273.15); // Convertir temperatura de Kelvin a Celsius
      });
    } else {
      print('Error al cargar el clima');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima Actual'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Clima Actual para $_city:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Descripción: $_weatherDescription',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Temperatura: ${_temperature.toStringAsFixed(1)} °C',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WeatherView(),
  ));
}

