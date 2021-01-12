import 'package:flutter/material.dart';
import "../../models/Event.dart";

import '../../constants.dart';

class EventDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Project discussion  1'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, homeRoute),
          ),
        ),
        body: Container(
          // set margin of body
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              // user name
              BuildText("Time"),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Form(
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "08:00 AM until 11:00 AM",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              BuildText("Description"),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Form(
                  child: TextFormField(
                    maxLines: 15,
                    decoration: InputDecoration(
                      hintText: "Need to discuss with friend",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BuildFlatButton(
                    text: 'Delete',
                    color: Colors.red,
                    onPressedCallback: () => Navigator.pop(context, homeRoute),
                  ),
                  BuildFlatButton(
                    text: 'Edit',
                    color: Colors.blue,
                    onPressedCallback: () => Navigator.pop(context, homeRoute),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildText extends StatelessWidget {
  final text;
  const BuildText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 8, left: 8, right: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

class BuildFlatButton extends StatelessWidget {
  final text, color, onPressedCallback;
  const BuildFlatButton(
      {this.text, this.color: Colors.grey, this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 23),
      height: 50,
      width: 130,
      child: FlatButton(
        color: color,
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onPressedCallback,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
