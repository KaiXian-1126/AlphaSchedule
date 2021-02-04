import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:flutter/material.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

class EventCreateScreen extends StatefulWidget {
  final event, date;
  EventCreateScreen({this.event, this.date});

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

  String timeToStringConverter2(TimeOfDay time) {
    String stringTime = time.toString();
    String mytime;
    stringTime = stringTime.substring(10, 15);
    stringTime = stringTime.substring(0, 5);
    if (int.parse(stringTime.substring(0, 2)) >= 12) {
      int hour = (int.parse(stringTime.substring(0, 2)) - 12);
      int minute = int.parse(stringTime.substring(3, 5));
      mytime = "0${hour.toString()}:${minute.toString()}";
      stringTime = "$mytime PM";
    } else
      stringTime = "$stringTime AM";
    return stringTime;
  }

  TextEditingController titleController = TextEditingController(),
      descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      //Mock to get a user/////////////////////////
                      CalendarService mockDependency = di.dependency();
                      Calendar mockCalendar = await mockDependency.getCalendar(
                          cid: 'Hf9ucu5ztrKfDp3NtbZ5');
                      /////////////////////////////////////////////
                      String eventStartTime = timeToStringConverter2(startTime);
                      String eventEndTime = timeToStringConverter2(endTime);
                      Event newEvent = Event(
                          eventName: titleController.text,
                          //calendar: widget.date,
                          calendar: '2021-02-26',
                          startTime: eventStartTime,
                          endTime: eventEndTime,
                          description: descController.text);
                      //    final event = await eventDependency.createEvent(
                      //       id: "${mockCalendar.calendarId}", event: newEvent);
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
        var date = new DateTime.now();
        print(date);
        print(startTime);
        String a = timeToStringConverter2(startTime);
        print(a);
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
