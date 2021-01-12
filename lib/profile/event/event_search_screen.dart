import 'package:flutter/material.dart';

class EventSearchScreen extends StatefulWidget {
  @override
  _EventSearchScreenState createState() => _EventSearchScreenState();
}

class _EventSearchScreenState extends State<EventSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calender 1"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Title",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
          ),
        ));
  }
}
