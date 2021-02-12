import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/event/event_detail/event_detail_viewmodel.dart';
import 'package:alpha_schedule/screens/view.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class EventDetailsScreen extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => EventDetailsScreen());

  final Event c = dependency<EventDetailsViewmodel>().currentEvent;
  @override
  Widget build(BuildContext context) {
    return View<EventDetailsViewmodel>(
      builder: (context, viewmodel, _) {
        return Container(
          child: Scaffold(
              appBar: AppBar(
                title: Text(c.eventName),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Container(
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
                            hintText: "${viewmodel.getDate(c.calendar)}" +
                                "\t     " +
                                "${viewmodel.getDay(c.calendar)}",
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
                                "${Event().timeToStringConverter(c.startTime)} to ${Event().timeToStringConverter(c.endTime)}",
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
                            hintText: c.description,
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
                              await Navigator.pushNamed(
                                  context, eventEditRoute);
                              viewmodel.rebuild();
                            }),
                        BuildFlatButton(
                          text: 'Cancel',
                          color: Colors.red,
                          onPressedCallback: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        );
      },
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
