import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event_mock.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:flutter/material.dart';

import '../../constants.dart';

class EventSearchScreen extends StatefulWidget {
  final eventList;
  EventSearchScreen({this.eventList});
  @override
  _EventSearchScreenState createState() => _EventSearchScreenState(eventList);
}

class _EventSearchScreenState extends State<EventSearchScreen> {
  int tileCount;
  String searchText;
  List<int> displayIndex;
  List<Event> displayEvent;
  EventService eventDependency = di.dependency();

  //get event list
  Future<List> futureEventList;
  List eventLists = [];

  _EventSearchScreenState(eventList) {
    tileCount = eventList.eventList.length + 1;
    displayIndex =
        List.generate(eventList.eventList.length, (int index) => index);
  }
  getEventInformation(eventList) async {
    Calendar calendar = eventList;
    futureEventList = eventDependency.getEventList(c: calendar);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getEventInformation(widget.eventList);

    return FutureBuilder(
        future: Future.wait([futureEventList]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            eventLists = snapshot.data[0];

            return Scaffold(
              appBar: AppBar(
                title: Text("${widget.eventList.calendarName}"),
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
                    }),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Calendar on Loading..."),
              ),
              body: Center(child: CircularProgressIndicator()),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.black54,
                // currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text("home")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today), title: Text("Summary")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.share), title: Text("Share")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), title: Text("Create")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), title: Text("Search")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), title: Text("Setting")),
                ],
              ),
            );
          }
        });
  }
}
