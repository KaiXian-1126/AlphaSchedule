import 'package:alpha_schedule/models/Event.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class EventSearchScreen extends StatefulWidget {
  List<Event> eventList;
  EventSearchScreen({this.eventList});
  @override
  _EventSearchScreenState createState() => _EventSearchScreenState(eventList);
}

class _EventSearchScreenState extends State<EventSearchScreen> {
  int tileCount;
  String searchText;
  List<int> displayIndex;
  List<Event> displayEvent;
  _EventSearchScreenState(eventList) {
    tileCount = eventList.length + 1;
    displayIndex = List.generate(eventList.length, (int index) => index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calender 1"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: ListView.separated(
            itemCount: tileCount,
            separatorBuilder: (_, index) => Divider(),
            itemBuilder: (_, index) {
              if (index == 0) {
                return TextFormField(
                  onChanged: (text) {
                    setState(() {
                      int i = 0;
                      searchText = text;
                      tileCount = 1;
                      displayIndex.clear();
                      widget.eventList.forEach((e) {
                        if (text.toUpperCase() ==
                            e.eventName
                                .substring(0, text.length)
                                .toUpperCase()) {
                          tileCount++;
                          displayIndex.add(i);
                        }
                        i++;
                      });
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                );
              } else {
                return ListTile(
                  title:
                      Text(widget.eventList[displayIndex[index - 1]].eventName),
                  onTap: () => Navigator.pushNamed(context, eventDetailsRoute,
                      arguments: widget.eventList[displayIndex[index - 1]]),
                );
              }
            }),
      ),
    );
  }
}
