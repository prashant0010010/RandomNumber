import 'package:flutter/material.dart';
import 'package:randomappgenerate/random/Bonus.dart';
import 'package:randomappgenerate/random/oddeven.dart';
import 'package:randomappgenerate/random/randomcountry.dart';
import 'package:randomappgenerate/random/randomletter.dart';
import 'package:randomappgenerate/random/randomnumber.dart';
import 'package:randomappgenerate/random/randomword.dart';
import 'home.dart';
import 'splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomize App',
      // initialRoute: '/home', // Initial route when the app starts
      routes: {
        '/splash': (context) => SplashScreen(),
       '/home': (context) => HomeScreen(),
        '/random_letter': (context) => RandomLetterScreen(),
        '/random_country': (context) => RandomCountryScreen(),
        '/random_number': (context) => RandomNumberScreen(),
        '/random_word' : (context)=> RandomWordGenerator(),
        '/oddeven': (context)=> OddEvenPage(),
        'bonus': (context)=> Bonus(),
      

      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, 
      home: SplashScreen(),
    );
  }
}
