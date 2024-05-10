import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randomappgenerate/random/memory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Bonus(),
    );
  }
}

class Bonus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlphabetGuessingGame()),
                );
              },
              child: Text('Alphabet Guessing Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NumberGuessingGame()),
                );
              },
              child: Text('Number Guessing Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryMatchGame()),
                );
              },
              child: Text('Memory Matching Game'),
            ),
          ],
        ),
      ),
    );
  }
}

class AlphabetGuessingGame extends StatefulWidget {
  @override
  _AlphabetGuessingGameState createState() => _AlphabetGuessingGameState();
}

class _AlphabetGuessingGameState extends State<AlphabetGuessingGame> {
  final Random _random = Random();
  late String _randomAlphabet;
  late TextEditingController _controller;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    _randomAlphabet = String.fromCharCode(_random.nextInt(26) + 65);
    _controller = TextEditingController();
    _message = '';
  }

  void _checkGuess() {
    if (_controller.text.toUpperCase() == _randomAlphabet) {
      setState(() {
        _message = 'Correct! It was $_randomAlphabet';
      });
    } else {
      setState(() {
        _message = 'Incorrect. Try again!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabet Guessing Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guess the Alphabet (A-Z)',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLength: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                hintText: 'Enter Alphabet',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkGuess,
              child: Text('Check'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resetGame();
                });
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberGuessingGame extends StatefulWidget {
  @override
  _NumberGuessingGameState createState() => _NumberGuessingGameState();
}

class _NumberGuessingGameState extends State<NumberGuessingGame> {
  final Random _random = Random();
  late int _randomNumber;
  late TextEditingController _controller;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    _randomNumber = _random.nextInt(100) + 1;
    _controller = TextEditingController();
    _message = '';
  }

  void _checkGuess() {
    int? guess = int.tryParse(_controller.text);
    if (guess != null && guess == _randomNumber) {
      setState(() {
        _message = 'Correct! It was $_randomNumber';
      });
    } else {
      setState(() {
        _message = 'Incorrect. Try again!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Guessing Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guess the Number (1-100)',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                hintText: 'Enter Number',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkGuess,
              child: Text('Check'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resetGame();
                });
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
