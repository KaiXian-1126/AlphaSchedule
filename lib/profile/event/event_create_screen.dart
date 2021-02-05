import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:flutter/material.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:intl/intl.dart';

class EventCreateScreen extends StatefulWidget {
  final calendar, date;
  EventCreateScreen({this.calendar, this.date});

  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  final EventService eventDependency = di.dependency();
  dynamic startTime, endTime, title, description;
  String timeToStringConverter(TimeOfDay time) {
    String stringTime = time.toString();
    stringTime = stringTime.substring(10, 15);
    if (int.parse(stringTime.substring(0, 2)) >= 12)
      stringTime = "$stringTime PM";
    else
      stringTime = "$stringTime AM";
    return stringTime;
  }

  TextEditingController titleController = TextEditingController(),
      descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String selectedDate = DateFormat('yyyy-MM-dd').format(widget.date);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          BuildText("Title"),
          BuildTextField(
            controller: titleController,
            textFieldContent: null,
          ),
          BuildText("Start Time"),
          Container(
            margin: EdgeInsets.all(4.0),
            child: Card(
              child: ListTile(
                  title: Text(startTime == null
                      ? "Choose the start time"
                      : timeToStringConverter(startTime)),
                  onTap: () async {
                    final selectedTime = await showTimePicker(
                      initialTime:
                          startTime == null ? TimeOfDay.now() : startTime,
                      context: context,
                    );
                    if (selectedTime != null) {
                      setState(() {
                        startTime = selectedTime;
                      });
                    }
                  }),
            ),
          ),
          BuildText("End Time"),
          Container(
            margin: EdgeInsets.all(4.0),
            child: Card(
              child: ListTile(
                  title: Text(endTime == null
                      ? "Choose the end time"
                      : timeToStringConverter(endTime)),
                  onTap: () async {
                    final selectedTime = await showTimePicker(
                      initialTime: endTime == null ? TimeOfDay.now() : endTime,
                      context: context,
                    );
                    if (selectedTime != null) {
                      setState(() {
                        endTime = selectedTime;
                      });
                    }
                  }),
            ),
          ),
          BuildText("Description"),
          BuildTextField(
              maxLines: 15, controller: descController, textFieldContent: null),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BuildFlatButton(
                  text: "Add",
                  color: Colors.blue,
                  onPressedCallback: () async {
                    if (titleController.text != "" &&
                        startTime != null &&
                        endTime != null &&
                        description != "") {
                      Event newEvent = Event(
                          eventName: titleController.text,
                          calendar: selectedDate,
                          startTime: timeToStringConverter(startTime),
                          endTime: timeToStringConverter(endTime),
                          description: descController.text,
                          calendarId: widget.calendar.calendarId);
                      final event = await eventDependency.createEvent(
                          calendarId: "${widget.calendar.calendarId}",
                          event: newEvent);
                    }
                    Navigator.pop(
                      context,
                    );
                  }),
              BuildFlatButton(
                text: "Cancel",
                color: Colors.grey,
                onPressedCallback: () => Navigator.pop(context),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        print(widget.calendar.calendarId);
        print(selectedDate);
      }),
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
      margin: EdgeInsets.all(8.0),
      child: FlatButton(
        color: color,
        child: Text(text),
        onPressed: onPressedCallback,
      ),
    );
  }
}

class BuildTextField extends StatelessWidget {
  final maxLines, textFieldContent, controller;
  BuildTextField(
      {this.maxLines: 1, this.textFieldContent: "", this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        initialValue: textFieldContent,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        maxLines: maxLines,
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
