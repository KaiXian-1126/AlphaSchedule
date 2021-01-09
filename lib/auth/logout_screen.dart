import 'package:alpha_schedule/landing/welcome_screen.dart';

import 'package:flutter/material.dart';

class LogoutScreen extends StatefulWidget {
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: Colors.blue),
            child:
                ListView(padding: EdgeInsets.only(top: 150), children: <Widget>[
              _Text("Alpha"),
              _Text("Schedule Management"),
              SizedBox(height: 30),
              Image.asset('assets/logo.png', height: 250.0, width: 250.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 170,
                width: 300,
                margin:
                    EdgeInsets.only(top: 40, bottom: 20, left: 70, right: 70),
                child: ListView(children: <Widget>[
                  _Text("You Have"),
                  _Text("Sucessfully Logout!"),
                ]),
              ),
              Container(
                width: 50,
                height: 50,
                margin:
                    EdgeInsets.only(top: 10, bottom: 20, left: 70, right: 70),
                child: BuildFlatButton(
                  text: 'Return to Home Page',
                  color: Colors.white,
                  onpressedcallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
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
      style: TextStyle(color: Colors.black, fontSize: 30.0),
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
