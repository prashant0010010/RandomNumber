import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randomappgenerate/random/Bonus.dart';
import 'package:randomappgenerate/random/oddeven.dart';
import 'package:randomappgenerate/random/randomcountry.dart';
import 'package:randomappgenerate/random/randomletter.dart';
import 'package:randomappgenerate/random/randomnumber.dart';
import 'package:randomappgenerate/random/randomword.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _randomNumber = 0;

  void _generateRandomNumber() {
    setState(() {
      _randomNumber =
          Random().nextInt(100); // Generate a random number between 0 and 99
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
              title: Text('Random Number'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RandomNumberScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Random Letter'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RandomLetterScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Random Word'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RandomWordGenerator()),
                );
              },
            ),
            ListTile(
              title: Text('Random Country'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RandomCountryScreen()),
                );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Random Number:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              '$_randomNumber',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateRandomNumber,
              child: Text('Generate Random Number'),
            ),
          ],
        ),
      ),
    );
  }
}
