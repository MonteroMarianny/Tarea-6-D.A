import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UniversityListView extends StatefulWidget {
  @override
  _UniversityListViewState createState() => _UniversityListViewState();
}

class _UniversityListViewState extends State<UniversityListView> {
  TextEditingController _countryController = TextEditingController();
  List<University> _universities = [];

  Future<void> fetchUniversities(String country) async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<University> universities = data.map((json) => University.fromJson(json)).toList();
      setState(() {
        _universities = universities;
      });
    } else {
      print('Error al cargar las universidades');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por país'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'País (en inglés)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String country = _countryController.text.trim();
              if (country.isNotEmpty) {
                fetchUniversities(country);
              }
            },
            child: Text('Buscar universidades'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _universities.length,
              itemBuilder: (context, index) {
                University university = _universities[index];
                return ListTile(
                  title: Text(university.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dominio: ${university.domain}'),
                      Text('Página web: ${university.webPage}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class University {
  final String name;
  final String domain;
  final String webPage;

  University({
    required this.name,
    required this.domain,
    required this.webPage,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? 'Desconocido',
      domain: json['domains'] != null ? (json['domains'] as List).first ?? 'No disponible' : 'No disponible',
      webPage: json['web_pages'] != null ? (json['web_pages'] as List).first ?? 'No disponible' : 'No disponible',
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UniversityListView(),
  ));
}