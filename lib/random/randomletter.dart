import 'package:flutter/material.dart';
import 'dart:math';

import 'package:randomappgenerate/random/oddeven.dart';

class RandomLetterScreen extends StatefulWidget {
  @override
  _RandomLetterScreenState createState() => _RandomLetterScreenState();
}

class _RandomLetterScreenState extends State<RandomLetterScreen> {
  String alphabet = 'abcdefghijklmnopqrstuvwxyz';
  late String randomLetter;

  @override
  void initState() {
    super.initState();
    generateRandomLetter();
  }

  void generateRandomLetter() {
    setState(() {
      randomLetter = alphabet[Random().nextInt(alphabet.length)]; // Generate a random letter
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Letter'),
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
              title: Text('Random Number'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, '/random_number');
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
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          generateRandomLetter(); // Generate a new random letter on tap
        },
        child: Center(
          child: Text(
            'Random Letter: $randomLetter',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
