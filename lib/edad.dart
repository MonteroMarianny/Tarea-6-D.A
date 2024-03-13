import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgePredictionView extends StatefulWidget {
  @override
  _AgePredictionViewState createState() => _AgePredictionViewState();
}

class _AgePredictionViewState extends State<AgePredictionView> {
  TextEditingController _nameController = TextEditingController();
  String _agePrediction = '';

  Future<void> predictAge() async {
    String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        int age = data['age'] as int;
        setState(() {
          if (age <= 25) {
            _agePrediction = 'Joven';
          } else if (age <= 60) {
            _agePrediction = 'Adulto';
          } else {
            _agePrediction = 'Anciano';
          }
        });
      } else {
        setState(() {
          _agePrediction = 'Error en la solicitud';
        });
      }
    } else {
      setState(() {
        _agePrediction = 'Por favor ingresa un nombre';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de edad'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
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
              onPressed: predictAge,
              child: Text('Predecir edad'),
            ),
            SizedBox(height: 20.0),
            Text(
              _agePrediction,
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
    home: AgePredictionView(),
  ));
}
