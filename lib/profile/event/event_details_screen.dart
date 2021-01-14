import 'package:alpha_schedule/models/Event.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class EventDetailsScreen extends StatefulWidget {
  final event;
  EventDetailsScreen({this.event});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.event.eventName),
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
                    enabled: false,
                    decoration: InputDecoration(
                      hintText:
                          "${widget.event.timeToStringConverter(widget.event.startTime)} to ${widget.event.timeToStringConverter(widget.event.endTime)}",
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
                    enabled: false,
                    maxLines: 15,
                    decoration: InputDecoration(
                      hintText: widget.event.description,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BuildFlatButton(
                      text: 'Edit',
                      color: Colors.blue,
                      onPressedCallback: () async {
                        final res = await Navigator.pushNamed(
                            context, eventEditRoute,
                            arguments: widget.event);
                        if (res != null) {
                          setState(() {});
                        }
                      }),
                  BuildFlatButton(
                    text: 'Cancel',
                    color: Colors.red,
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
