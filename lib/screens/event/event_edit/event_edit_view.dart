import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/event/event_detail/event_detail_viewmodel.dart';
import 'package:alpha_schedule/screens/event/event_edit/event_edit_viewmodel.dart';
import 'package:alpha_schedule/screens/home/home_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../view.dart';

class EventEditScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => EventEditScreen());

  @override
  _EventEditScreenState createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  Event c = dependency<EventDetailsViewmodel>().currentEvent;
  Event events;

  dynamic tempStartTime, tempEndTime;

  TextEditingController titleController, descriptionController;

  bool assigned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Event"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
      body: View<EventEditViewmodel>(
        builder: (context, viewmodel, _) {
          if (!assigned) {
            //initialise data
            titleController = TextEditingController(text: "${c.eventName}");
            descriptionController =
                TextEditingController(text: "${c.description}");
            tempStartTime = c.startTime;
            tempEndTime = c.endTime;
            assigned = true;
          }
          return ListView(
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
                      title: Text(Event().timeToStringConverter(tempStartTime)),
                      onTap: () async {
                        final selectedTime = await showTimePicker(
                          initialTime: tempStartTime,
                          context: context,
                        );
                        if (selectedTime != null) {
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
                      title: Text(Event().timeToStringConverter(tempEndTime)),
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
                        // update database
                        viewmodel.updateSelectedEvent(
                            id: c.eventId,
                            name: titleController.text,
                            startTime:
                                Event().timeToStringConverter(tempStartTime),
                            endTime: Event().timeToStringConverter(tempEndTime),
                            desc: descriptionController.text);
                        // update interface state
                        c.eventName = titleController.text;
                        c.startTime = tempStartTime;
                        c.endTime = tempEndTime;
                        c.description = descriptionController.text;
                        dependency<HomeViewmodel>()
                            .dayEvents
                            .forEach((element) {
                          if (element.eventId == c.eventId)
                            element.eventName = titleController.text;
                        });
                        Navigator.pop(context);
                        viewmodel.rebuild();
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
          );
        },
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
