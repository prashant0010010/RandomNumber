import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Word Generator',
      home: RandomWordGenerator(),
    );
  }
}

class RandomWordGenerator extends StatefulWidget {
  @override
  _RandomWordGeneratorState createState() => _RandomWordGeneratorState();
}

class _RandomWordGeneratorState extends State<RandomWordGenerator> {
  String generatedWord = '';
  
  @override
  void initState() {
    super.initState();
    generateRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Word Generator'),
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
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Generated Word:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              generatedWord,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateRandomWord,
              child: Text('Generate Random Word'),
            ),
          ],
        ),
      ),
    );
  }

void generateRandomWord() async {
  final response = await http.get(Uri.parse('https://random-word-api.herokuapp.com/word'));
  if (response.statusCode == 200) {
    final String word = response.body; // Parse response body as a string
    setState(() {
      generatedWord = word;
    });
  } else {
    setState(() {
      generatedWord = 'Error: Failed to load word';
    });
  }
}

}
