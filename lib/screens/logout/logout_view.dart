import 'package:alpha_schedule/constants.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => LogoutScreen());
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(padding: EdgeInsets.only(top: 50), children: <Widget>[
          _Text("Alpha", 28.0),
          _Text("Schedule Management", 28.0),
          SizedBox(height: 30),
          Image.asset('assets/logo.png', height: 100.0, width: 100.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 400,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: ListView(children: [
              _Text("You Have", 16.0),
              _Text("Sucessfully Logout!", 16.0),
              BuildFlatButton(
                  text: 'Return to Home Page',
                  color: Colors.white,
                  onpressedcallback: () {
                    Navigator.popAndPushNamed(context, welcomeRoute);
                  }),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final text, fontSize;
  const _Text(this.text, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: fontSize),
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
    return Container(
      margin: EdgeInsets.only(top: 150),
      child: FlatButton(
        color: Colors.blue,
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onpressedcallback,
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
