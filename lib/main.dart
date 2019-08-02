import 'package:flutter/material.dart';
import 'dart:async';
import 'package:newproject/login.dart';


void main() {
  runApp(
    new MaterialApp(
      home: SplachScreen(),
    ),
  );
}

class SplachScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplachScreen> {
  void handleTimeout() {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), handleTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('image/cart.png'),
            CircularProgressIndicator(),
            // Padding(padding: EdgeInsets.only(top: 300.0),)
          ],
        ),
      ),
    );
  }
}

