import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenderPredictionView extends StatefulWidget {
  @override
  _GenderPredictionViewState createState() => _GenderPredictionViewState();
}

class _GenderPredictionViewState extends State<GenderPredictionView> {
  TextEditingController _nameController = TextEditingController();
  String _genderPrediction = '';
  Color _backgroundColor = Colors.white;

  Future<void> predictGender() async {
    String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['gender'] == 'male') {
          setState(() {
            _genderPrediction = 'Masculino';
            _backgroundColor = Colors.blue;
          });
        } else if (data['gender'] == 'female') {
          setState(() {
            _genderPrediction = 'Femenino';
            _backgroundColor = Colors.pink;
          });
        } else {
          setState(() {
            _genderPrediction = 'No se pudo determinar';
            _backgroundColor = Colors.white;
          });
        }
      } else {
        setState(() {
          _genderPrediction = 'Error en la solicitud';
          _backgroundColor = Colors.white;
        });
      }
    } else {
      setState(() {
        _genderPrediction = 'Por favor ingresa un nombre';
        _backgroundColor = Colors.white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de género'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: _backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: predictGender,
              child: Text('Predecir género'),
            ),
            SizedBox(height: 20.0),
            Text(
              _genderPrediction,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GenderPredictionView(),
  ));
}
