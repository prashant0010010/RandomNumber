import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });
  }

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 85, 165, 236),
    body: Center(
      child: DelayedAnimation(
        delayDuration: Duration(milliseconds: 500),
        animationDuration: Duration(milliseconds: 1000),
        child: FadeTransition(
          opacity: _animation,
          child: Text(
            TypewriterAnimatedText(
              'Random Anything',
              textStyle: TextStyle(
                fontSize: 100.0,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              speed: Duration(milliseconds: 100), // Adjust typing speed
            ).text, // Wrap TypewriterAnimatedText with .text
          ),
        ),
      ),
    ),
  );
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DelayedAnimation extends StatelessWidget {
  final Widget child;
  final Duration delayDuration;
  final Duration animationDuration;

  const DelayedAnimation({
    required this.child,
    required this.delayDuration,
    required this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(delayDuration),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        } else {
          return AnimatedOpacity(
            opacity: 1,
            duration: animationDuration,
            child: child,
          );
        }
      },
    );
  }
}
