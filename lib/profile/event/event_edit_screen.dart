import 'package:flutter/material.dart';

class EventEditScreen extends StatefulWidget {
  dynamic startTime, endTime, title, description;
  EventEditScreen(this.title, this.startTime, this.endTime, this.description);
  String timeToStringConverter(TimeOfDay time) {
    String stringTime = time.toString();
    stringTime = stringTime.substring(10, 15);
    if (int.parse(stringTime.substring(0, 2)) >= 12)
      stringTime = "$stringTime PM";
    else
      stringTime = "$stringTime AM";
    print(stringTime);
    return stringTime;
  }

  void setStartTime(TimeOfDay st) {
    startTime = st;
  }

  void setEndTime(TimeOfDay et) {
    endTime = et;
  }

  @override
  _EventEditScreenState createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Event"),
        leading: Icon(Icons.arrow_back),
      ),
      body: ListView(
        children: [
          BuildText("Title"),
          BuildTextField(
            textFieldContent: widget.title,
          ),
          BuildText("Start Time"),
          Container(
            margin: EdgeInsets.all(4.0),
            child: Card(
              child: ListTile(
                  title: Text(widget.timeToStringConverter(widget.startTime)),
                  onTap: () async {
                    final selectedTime = await showTimePicker(
                      initialTime: widget.startTime,
                      context: context,
                    );
                    if (selectedTime != null) {
                      print(selectedTime);
                      setState(() {
                        widget.startTime = selectedTime;
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
                  title: Text(widget.timeToStringConverter(widget.endTime)),
                  onTap: () async {
                    final selectedTime = await showTimePicker(
                      initialTime: widget.endTime,
                      context: context,
                    );
                    if (selectedTime != null) {
                      setState(() {
                        print(selectedTime);
                        widget.endTime = selectedTime;
                      });
                    }
                  }),
            ),
          ),
          BuildText("Description"),
          BuildTextField(maxLines: 15, textFieldContent: widget.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue,
                  child: Text("Update"),
                  onPressed: () {
                    //Update to database code
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.grey,
                  child: Text("Cancel"),
                  onPressed: () {
                    //Back to event_details_screen
                  },
                ),
              ),
            ],
          )
        ],
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
