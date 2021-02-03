import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/user.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/calendar/calendar_service_mock.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

import '../models/Event.dart';

class DrawerScreen extends StatefulWidget {
  final user;
  DrawerScreen({this.user});

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int currentCalendarIndex = 0;
  CalendarController _controller;
  int _currentIndex = 0;
  CalendarService calendarDependency = di.dependency();
  EventService eventDependency = di.dependency();
  //Required User Information
  List calendarList, collaboratorCalendarList;
  getRequiredUserInformation() async {
    calendarList = await calendarDependency.getCalendarList(user: widget.user);
    collaboratorCalendarList =
        await calendarDependency.getCollaboratorCalendarList(user: widget.user);
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<ValueNotifier<User>>(context).value;
    DateTime time = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text(calendarList[currentCalendarIndex].calendarName),
      ),
      body: ListView.separated(
          //Call event data service
          itemCount:
              1 /*+
              eventDependency
                  .getEventList(widget.user.calendarList[currentCalendarIndex],
                      _controller.selectedDay, time)
                  .length*/
          ,
          separatorBuilder: (_, index) => Divider(),
          itemBuilder: (_, index) {
            /*List<Event> tempCalendarList = dependency.getEventList(
                widget.user.calendarList[currentCalendarIndex],
                _controller.selectedDay,
                time);*/
            if (index == 0) {
              return TableCalendar(
                availableCalendarFormats: {CalendarFormat.month: 'Month'},
                calendarController: _controller,
                calendarStyle: CalendarStyle(
                    contentDecoration: BoxDecoration(
                      color:
                          widget.user.calendarList[currentCalendarIndex].color,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                      ],
                    ),
                    weekendStyle: TextStyle(color: Colors.blue),
                    selectedColor: Colors.blue[300],
                    todayColor: Colors.green[300],
                    selectedStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    )),
                onDaySelected: (selectedDay, a, b) {
                  setState(() {});
                },
              );
            } else {
              return ListTile(
                  title: Text(
                      /*dependency.getEventName(tempCalendarList[index - 1])*/
                      "Event Test"),
                  onTap: () async {
                    final respond = await Navigator.pushNamed(
                      context,
                      eventDetailsRoute,
                      /*arguments:
                            dependency.getEvent(tempCalendarList[index - 1])*/
                    );
                    if (respond != null) {
                      setState(() {});
                    }
                  });
            }
          }),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final respond = await Navigator.pushNamed(
                                context, userProfileRoute,
                                arguments: widget.user);
                            if (respond != null) {
                              setState(() {});
                            }
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/me.jpg'),
                            maxRadius: 40,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40, left: 25),
                      child: Column(children: <Widget>[
                        Text("${widget.user.name}\n",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("${widget.user.email}",
                            style: TextStyle(fontSize: 10)),
                      ]),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            BuildText("Calendar List"),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              height: 250,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: calendarList.length,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.black),
                itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/calendar.png'),
                      maxRadius: 30,
                    ),
                    title: Text(widget.user.calendarList[index].calendarName),
                    onTap: () {
                      setState(() {
                        currentCalendarIndex = index;
                      });
                      Navigator.pop(context);
                    },
                    trailing: OutlineButton(
                      child: Icon(Icons.delete),
                      onPressed: () {
                        if (widget.user.calendarList.length > 1) {
                          widget.user.calendarList.removeAt(index);
                        }
                        setState(() {});
                      },
                    )),
              ),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                await Navigator.pushNamed(context, calendarCreateRoute,
                    arguments: widget.user.calendarList);
                setState(() {});
              },
              child: Icon(Icons.add),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 30),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogoutScreen()));
                },
                child: Text("Logout", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     heroTag: null,
      //     onPressed: () {
      //       print(user.calendarList.length);
      //       print(currentCalendarIndex);
      //       print(user.calendarList[currentCalendarIndex].eventList.length);
      //     }),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black54,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text("Summary")),
          BottomNavigationBarItem(
              icon: Icon(Icons.share), title: Text("Share")),
          BottomNavigationBarItem(icon: Icon(Icons.add), title: Text("Create")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Search")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Setting")),
        ],
        onTap: (index) async {
          _currentIndex = index;
          if (index == 1) {
            final response = await Navigator.pushNamed(
                context, eventSummaryRoute,
                arguments: widget.user.calendarList[currentCalendarIndex]);
            if (response != null) {
              setState(() {});
            }
          } else if (index == 2) {
            final response = await Navigator.pushNamed(
                context, calendarCollaboratorRoute, arguments: [
              widget.user.calendarList[currentCalendarIndex],
              widget.user
            ]);
          } else if (index == 3) {
            final response = await Navigator.pushNamed(
                context, eventCreateRoute,
                arguments: [
                  widget.user.calendarList[currentCalendarIndex].eventList,
                  _controller.selectedDay
                ]);

            // Event e = response;
            setState(() {
              // print(user.calendarList[currentCalendarIndex].eventList.length);
              // e.calendar = _controller.selectedDay;
              // user.calendarList[currentCalendarIndex].eventList.add(e);
              // print(user.calendarList[currentCalendarIndex].eventList.length);
            });
          } else if (index == 4) {
            Navigator.pushNamed(context, eventSearchRoute,
                arguments:
                    widget.user.calendarList[currentCalendarIndex].eventList);
          } else if (index == 5) {
            final response = await Navigator.pushNamed(
                context, calendarSettingsRoute,
                arguments: widget.user.calendarList[currentCalendarIndex]);
            if (response != null) {
              setState(() {});
            }
          }
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
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 50),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline),
      ),
    );
  }
}
