import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Bonus.dart';
import 'oddeven.dart';

class RandomCountryScreen extends StatefulWidget {
  @override
  _RandomCountryScreenState createState() => _RandomCountryScreenState();
}

class _RandomCountryScreenState extends State<RandomCountryScreen> {
  late List<String> countries;
  late String currentRandomCountry;

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final response = await http.get(Uri.parse('https://api.first.org/data/v1/countries'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Map<String, dynamic> countriesData = data['data'];
      countries = countriesData.values.map<String>((countryData) => countryData['country']).toList();
      setCurrentRandomCountry();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  void setCurrentRandomCountry() {
    if (countries.isNotEmpty) {
      setState(() {
        currentRandomCountry = countries[Random().nextInt(countries.length)];
      });
    }
  }

  String getRandomCountry() {
    if (countries.isNotEmpty) {
      return currentRandomCountry;
    } else {
      return 'Loading...'; // Handle loading state
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Country'),
      ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Randomize',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text('Random Letter'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, '/random_letter');
              },
            ),
            ListTile(
              title: Text('Random Country'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, '/random_country');
              },
            ),
            ListTile(
              title: Text('Odd Even'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OddEvenPage()),
                );
              },
            ),
             ListTile(
              title: Text('Bonus'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Bonus()),
                );
              },
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setCurrentRandomCountry();
        },
        child: Center(
          child: Text(
            'Random Country: ${getRandomCountry()}',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
