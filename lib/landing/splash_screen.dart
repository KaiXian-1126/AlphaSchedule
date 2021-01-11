import 'dart:async';

import 'package:alpha_schedule/landing/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AlphaSplashScreen extends StatefulWidget {
  @override
  _AlphaSplashScreen createState() => _AlphaSplashScreen();
}

class _AlphaSplashScreen extends State<AlphaSplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 0),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/logo.png', height: 250.0, width: 250.0),
                  SizedBox(height: 30.0),
                  SpinKitRipple(color: Colors.black, size: 100.0),
                  SizedBox(height: 30.0),
                  Text(
                    "Alpha",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Schedule Management",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                    textAlign: TextAlign.center,
                  )
                ])));
  }
}
