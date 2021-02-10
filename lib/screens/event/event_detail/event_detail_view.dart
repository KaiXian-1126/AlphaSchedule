import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/event/event_detail/event_detail_viewmodel.dart';
import 'package:alpha_schedule/screens/view.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class EventDetailsScreen extends StatelessWidget {
  final event;
  EventDetailsScreen({this.event});

  bool assigned = false;
  Event events;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text(event.eventName),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, events),
            ),
          ),
          body: View<EventDetailsViewmodel>(
            initViewmodel: (viewmodel) => viewmodel.getEvent(id: event.eventId),
            builder: (context, viewmodel, _) {
              if (!assigned) {
                events = viewmodel.events;
                assigned = true;
              }
              return Container(
                // set margin of body
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 12),
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
                            hintText: "${viewmodel.getDate(events.calendar)}" +
                                "\t     " +
                                "${viewmodel.getDay(events.calendar)}",
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
                                "${Event().timeToStringConverter(events.startTime)} to ${Event().timeToStringConverter(events.endTime)}",
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
                            hintText: events.description,
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
                                  arguments: events.eventId);
                              if (res != null) {
                                viewmodel.rebuild;
                              }
                            }),
                        BuildFlatButton(
                          text: 'Cancel',
                          color: Colors.red,
                          onPressedCallback: () =>
                              Navigator.pop(context, events),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )),
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
