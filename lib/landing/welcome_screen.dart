import 'package:alpha_schedule/auth/account_create_screen.dart';
import 'package:alpha_schedule/auth/login_screen.dart';
import 'package:alpha_schedule/models/mockdata.dart';
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
              Image.asset('assets/logo.png', height: 250.0, width: 250.0),
              _Text("Alpha"),
              _Text("Schedule Management"),
              Container(
                width: 50,
                height: 50,
                margin:
                    EdgeInsets.only(top: 40, bottom: 20, left: 70, right: 70),
                child: BuildFlatButton(
                  text: 'Login',
                  color: Colors.white,
                  onpressedcallback: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ),
              Container(
                width: 50,
                height: 50,
                margin:
                    EdgeInsets.only(top: 10, bottom: 20, left: 70, right: 70),
                child: BuildFlatButton(
                  text: 'Get Started',
                  color: Colors.white,
                  onpressedcallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AccountCreateScreen(mockData)));
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
      style: TextStyle(color: Colors.white, fontSize: 30.0),
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
