import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    print(widget.event);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.event.eventName),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, widget.event),
          ),
        ),
        body: Container(
          // set margin of body
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 12),
          child: ListView(
            children: [
              // Event date
              BuildText("Date"),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Form(
                  child: TextFormField(
                    maxLines: 1,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "${getDate(widget.event.calendar)}" +
                          "\t     " +
                          "${getDay(widget.event.calendar)}",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              // Event Time
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
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              // Event Description
              BuildText("Description"),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Form(
                  child: TextFormField(
                    enabled: false,
                    maxLines: 15,
                    decoration: InputDecoration(
                      hintText: widget.event.description,
                      hintStyle: TextStyle(color: Colors.black),
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
                    onPressedCallback: () =>
                        Navigator.pop(context, widget.event),
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

String getDay(DateTime date) {
  return DateFormat('EEEE').format(date);
}

String getDate(DateTime value) {
  var dateParse = DateTime.parse(value.toString());
  String month = dateParse.month.toString();
  String day = dateParse.day.toString();
  if (month.length != 2) {
    month = "0$month";
  }
  if (day.length != 2) {
    day = "0$day";
  }
  String a = ("${dateParse.year}-$month-$day");
  return a;
}
