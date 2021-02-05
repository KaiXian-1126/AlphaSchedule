import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class EventSearchScreen extends StatefulWidget {
  EventSearchScreen();
  @override
  _EventSearchScreenState createState() => _EventSearchScreenState();
}

class _EventSearchScreenState extends State<EventSearchScreen> {
  int tileCount;
  String searchText;
  List<int> displayIndex;
  List<Event> displayEvent;
  bool assigned = false;
  EventService eventDependency = di.dependency();

  //get event list
  Future<List> futureEventList;
  List eventLists = [];

  /*_EventSearchScreenState() {
    tileCount = eventList.eventList.length + 1;
    displayIndex =
        List.generate(eventList.eventList.length, (int index) => index);
  }*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Calendar c =
        Provider.of<ValueNotifier<Calendar>>(context, listen: false).value;
    return Scaffold(
      appBar: AppBar(
        title: Text("${c.calendarName}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: eventDependency.getEventList(c: c),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (!assigned) {
                  eventLists = snapshot.data;
                  tileCount = eventLists.length + 1;
                  displayIndex =
                      List.generate(eventLists.length, (int index) => index);
                  assigned = true;
                }

                return ListView.separated(
                    itemCount: tileCount,
                    separatorBuilder: (_, index) => Divider(),
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        return TextFormField(
                          onChanged: (text) {
                            tileCount = 1;
                            searchText = text;
                            displayIndex.clear();
                            int i = 0;

                            setState(() {
                              eventLists.forEach((e) {
                                if (text.length <= e.eventName.length) {
                                  if ((text.toUpperCase() ==
                                      e.eventName
                                          .substring(0, text.length)
                                          .toUpperCase())) {
                                    tileCount++;
                                    displayIndex.add(i);
                                  }
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
                          title: Text(
                              eventLists[displayIndex[index - 1]].eventName),
                          onTap: () => Navigator.pushNamed(
                              context, eventDetailsRoute,
                              arguments: eventLists[displayIndex[index - 1]]),
                        );
                      }
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
