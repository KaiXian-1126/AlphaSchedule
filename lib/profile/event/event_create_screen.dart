import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/models/mockdata.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCreateScreen extends StatefulWidget {
  final date;
  EventCreateScreen({this.date});

  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  dynamic startTime, endTime, title, description;
  EventService eventDependency = di.dependency();
  String timeToStringConverter(TimeOfDay time) {
    String stringTime = time.toString();
    stringTime = stringTime.substring(10, 15);
    if (int.parse(stringTime.substring(0, 2)) > 12) {
      int hour = int.parse(stringTime.substring(0, 2)) - 12;
      String stringHour = "$hour";
      if (hour < 10) {
        stringHour = "0$hour";
      }
      stringTime = "$stringHour${stringTime.substring(2)}";
      stringTime = "$stringTime PM";
    } else if (int.parse(stringTime.substring(0, 2)) == 12) {
      stringTime = "$stringTime PM";
    } else if (int.parse(stringTime.substring(0, 2)) == 0) {
      stringTime = "12${stringTime.substring(2)} AM";
    } else {
      stringTime = "$stringTime AM";
    }
    return stringTime;
  }

  TextEditingController titleController = TextEditingController(),
      descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.date[0]);
    Calendar c =
        Provider.of<ValueNotifier<Calendar>>(context, listen: false).value;
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
                      await eventDependency.createEvent(
                          c: c,
                          event: Event(
                              calendarId: c.calendarId,
                              eventId: null,
                              eventName: titleController.text,
                              calendar: widget.date[0],
                              startTime: startTime,
                              endTime: endTime,
                              description: descController.text));
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
