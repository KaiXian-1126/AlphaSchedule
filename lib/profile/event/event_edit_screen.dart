import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:flutter/material.dart';

class EventEditScreen extends StatefulWidget {
  final event;
  EventEditScreen({this.event});

  @override
  _EventEditScreenState createState() => _EventEditScreenState(event);
}

class _EventEditScreenState extends State<EventEditScreen> {
  dynamic tempStartTime, tempEndTime, tempTitle, tempDescription;
  TextEditingController titleController, descriptionController;
  _EventEditScreenState(event) {
    tempStartTime = event.startTime;
    tempEndTime = event.endTime;
    titleController = TextEditingController(text: "${event.eventName}");
    descriptionController = TextEditingController(text: "${event.description}");
  }
  void setStartTime(TimeOfDay st) {
    tempStartTime = st;
  }

  void setEndTime(TimeOfDay et) {
    tempEndTime = et;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Event"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        children: [
          BuildText("Title"),
          Container(
            margin: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
          ),
          BuildText("Start Time"),
          Container(
            margin: EdgeInsets.all(4.0),
            child: Card(
              child: ListTile(
                  title:
                      Text(widget.event.timeToStringConverter(tempStartTime)),
                  onTap: () async {
                    final selectedTime = await showTimePicker(
                      initialTime: tempStartTime,
                      context: context,
                    );
                    if (selectedTime != null) {
                      print(selectedTime);
                      setState(() {
                        tempStartTime = selectedTime;
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
                  title: Text(widget.event.timeToStringConverter(tempEndTime)),
                  onTap: () async {
                    final selectedTime = await showTimePicker(
                      initialTime: tempEndTime,
                      context: context,
                    );
                    if (selectedTime != null) {
                      setState(() {
                        tempEndTime = selectedTime;
                      });
                    }
                  }),
            ),
          ),
          BuildText("Description"),
          Container(
            margin: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              maxLines: 15,
            ),
          ),
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
                    widget.event.eventName = titleController.text;
                    widget.event.description = descriptionController.text;
                    widget.event.startTime = tempStartTime;
                    widget.event.endTime = tempEndTime;
                    Navigator.pop(context, "Data Updated");
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.grey,
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
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
