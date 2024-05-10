import 'package:flutter/material.dart';
import 'dart:math';

import 'oddeven.dart';

class RandomNumberScreen extends StatefulWidget {
  @override
  _RandomNumberScreenState createState() => _RandomNumberScreenState();
}

class _RandomNumberScreenState extends State<RandomNumberScreen> {
  int randomNumber = Random().nextInt(100); // Generate a random number between 0 and 99

  void generateRandomNumber(int max) {
    setState(() {
      randomNumber = Random().nextInt(max); // Generate a new random number within the specified range
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Number'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showPopup(context);
            },
          ),
        ],
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
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          generateRandomNumber(100); // Generate a new random number between 0 and 99 on tap
        },
        child: Center(
          child: Text(
            'Random Number: $randomNumber',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int maxNumber = 100;
        return AlertDialog(
          title: Text('Generate Random Number'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter max number:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  maxNumber = int.tryParse(value) ?? 100;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                generateRandomNumber(maxNumber);
                Navigator.of(context).pop();
              },
              child: Text('Generate'),
            ),
          ],
        );
      },
    );
  }
}
