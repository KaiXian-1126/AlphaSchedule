import 'dart:async';

import 'package:alpha_schedule/constants.dart';
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

    Timer(Duration(seconds: 4), () {
      Navigator.popAndPushNamed(context, welcomeRoute);
    });
  }

  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logo.png', height: 100.0, width: 100.0),
              SizedBox(height: 30.0),
              Text(
                "Alpha",
                style: TextStyle(color: Colors.white, fontSize: 28.0),
                textAlign: TextAlign.center,
              ),
              Text(
                "Schedule Management",
                style: TextStyle(color: Colors.white, fontSize: 28.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
              ),
              SpinKitRipple(color: Colors.black, size: 50.0),
            ]),
      ),
    );
  }
}
