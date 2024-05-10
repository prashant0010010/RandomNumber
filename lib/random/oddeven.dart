import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randomappgenerate/random/randomcountry.dart';
import 'package:randomappgenerate/random/randomletter.dart';
import 'package:randomappgenerate/random/randomnumber.dart';
import 'package:randomappgenerate/random/randomword.dart';

import 'Bonus.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Odd Even Randomizer',
            theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
            home: OddEvenPage(),
    );
  }
}

class OddEvenPage extends StatefulWidget {
  @override
  _OddEvenPageState createState() => _OddEvenPageState();
}

class _OddEvenPageState extends State<OddEvenPage> {
  List<int> numbers = List.generate(10, (index) => index);
  int selectedIndex = -1;
  bool isAnimating = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startAnimation() {
    setState(() {
      isAnimating = true;
    });

    timer = Timer(Duration(seconds: 3), stopAnimation);
  }

  void stopAnimation() {
    final Random random = Random();
    final int randomIndex = random.nextInt(numbers.length);

    setState(() {
      selectedIndex = randomIndex;
      isAnimating = false;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Result'),
            content: Text(
              numbers[randomIndex] % 2 == 0 ? 'Even' : 'Odd',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Odd Even Randomizer'),
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
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: isAnimating ? Duration(milliseconds: 100) : Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? Colors.green : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      numbers[index].toString(),
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isAnimating ? null : startAnimation,
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
