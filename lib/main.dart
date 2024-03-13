import 'package:flutter/material.dart';
import 'clima.dart';
import 'edad.dart';
import 'genero.dart';
import 'universidades.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.grey[800]),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/clima': (context) => WeatherView(),
        '/edad': (context) => AgePredictionView(),
        '/genero': (context) => GenderPredictionView(),
        '/universidades': (context) => UniversityListView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/clima');
              },
              child: Text('Ver Clima'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edad');
              },
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/genero');
              },
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/universidades');
              },
              child: Text('Ver Universidades'),
            ),
          ],
        ),
      ),
    );
  }
}
