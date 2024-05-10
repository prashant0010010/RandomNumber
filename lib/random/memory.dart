import 'dart:async';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Match',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemoryMatchGame(),
    );
  }
}

class MemoryMatchGame extends StatefulWidget {
  @override
  _MemoryMatchGameState createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> with TickerProviderStateMixin {
  List<int> _items = List.generate(8, (index) => index ~/ 2).toList();
  List<bool> _flipped = List.filled(8, false);
  List<int> _flippedIndices = [];
  bool _isGameFinished = false;
  int _moves = 0;

  late AnimationController _celebrationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _resetGame();
    _celebrationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _celebrationController, curve: Curves.easeInOut);
  }

  void _resetGame() {
    _items.shuffle();
    _flipped = List.filled(8, false);
    _flippedIndices = [];
    _isGameFinished = false;
    _moves = 0;
  }

  void _onItemTapped(int index) {
    if (_flippedIndices.length == 2) {
      return;
    }

    setState(() {
      _flipped[index] = true;
      _flippedIndices.add(index);

      if (_flippedIndices.length == 2) {
        _moves++;

        if (_items[_flippedIndices[0]] != _items[_flippedIndices[1]]) {
          // If cards don't match, flip them back after a delay
          Timer(Duration(seconds: 1), () {
            setState(() {
              _flipped[_flippedIndices[0]] = false;
              _flipped[_flippedIndices[1]] = false;
              _flippedIndices.clear();
            });
          });
        } else {
          // If cards match, check if all pairs are matched
          if (!_flipped.contains(false)) {
            _isGameFinished = true;
            _celebrationController.forward();
          }
          _flippedIndices.clear();
        }
      }
    });
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Match'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('How to Play'),
                    content: Text('Tap on cards to flip them. Match pairs to win the game!'),
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
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: _flipped[index] || _isGameFinished
                        ? null
                        : () {
                            _onItemTapped(index);
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _flipped[index] || _isGameFinished ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: _flipped[index] || _isGameFinished
                            ? Text(
                                '${String.fromCharCode(_items[index] + 65)}',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              _isGameFinished
                  ? AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animation.value,
                          child: child,
                        );
                      },
                      child: IconButton(
                        icon: Icon(Icons.star, color: Colors.yellow, size: 50.0),
                        onPressed: () {
                          setState(() {
                            _celebrationController.reset();
                            _resetGame();
                          });
                        },
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 20.0),
              _isGameFinished
                  ? Text(
                      'Congratulations! You won in $_moves moves!',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _resetGame();
                  });
                },
                child: Text('Restart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
