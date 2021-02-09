import 'package:alpha_schedule/constants.dart';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: Colors.blue),
            child:
                ListView(padding: EdgeInsets.only(top: 150), children: <Widget>[
              Image.asset('assets/logo.png', height: 100.0, width: 100.0),
              SizedBox(
                height: 50,
              ),
              _Text("Alpha"),
              _Text("Schedule Management"),
              SizedBox(
                height: 100,
              ),
              Container(
                width: 50,
                height: 50,
                margin:
                    EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 10),
                child: BuildFlatButton(
                  text: 'Login',
                  color: Colors.white,
                  onpressedcallback: () {
                    Navigator.pushNamed(context, loginRoute);
                  },
                ),
              ),
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(top: 10, left: 50, right: 50),
                child: BuildFlatButton(
                  text: 'Get Started',
                  color: Colors.white,
                  onpressedcallback: () {
                    Navigator.pushNamed(context, accountCreateRoute);
                  },
                ),
              )
            ])));
  }
}

class _Text extends StatelessWidget {
  final text;
  const _Text(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 28.0),
      textAlign: TextAlign.center,
    );
  }
}

class BuildFlatButton extends StatelessWidget {
  final text, color, onpressedcallback;
  const BuildFlatButton(
      {this.text, this.color: Colors.white, this.onpressedcallback});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: onpressedcallback,
      textColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
