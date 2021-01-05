import 'package:flutter/material.dart';

class EventCreateScreen extends StatefulWidget {
  EventCreateScreen();

  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
        leading: Icon(Icons.arrow_back),
      ),
      body: ListView(
        children: [
          BuildText("Title"),
          BuildTextField(),
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
          BuildTextField(maxLines: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BuildFlatButton(
                text: "Add",
                color: Colors.blue,
                onPressedCallback: () {},
              ),
              BuildFlatButton(
                text: "Cancel",
                color: Colors.grey,
                onPressedCallback: () {},
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
  final maxLines, textFieldContent;
  BuildTextField({this.maxLines: 1, this.textFieldContent: ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextFormField(
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
