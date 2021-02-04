import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:intl/intl.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:alpha_schedule/services/event/event_service_rest.dart';
import 'package:alpha_schedule/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

import '../models/Event.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen();

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
<<<<<<< HEAD
  Future<List> futureCalendarList,
      futureCollaboratorCalendarList,
      futureEventList;
  List calendarList, collaboratorCalendarList, eventList;
  getRequiredUserInformation(user) async {
    futureCalendarList = calendarDependency.getCalendarList(user: user);
    futureCollaboratorCalendarList =
        calendarDependency.getCollaboratorCalendarList(user: user);
  }
=======
  Future<List> futureCalendarList, futureCollaboratorCalendarList;
  List calendarList, collaboratorCalendarList, eventList = [];
>>>>>>> remotes/origin/backend-kaixian

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ValueNotifier<User>>(context).value;
    DateTime time = DateTime.now();

    return FutureBuilder(
        future: Future.wait([
          calendarDependency.getCalendarList(user: user),
          calendarDependency.getCollaboratorCalendarList(user: user),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            calendarList = snapshot.data[0];
            collaboratorCalendarList = snapshot.data[1];
            return Scaffold(
              appBar: AppBar(
                title: Text(calendarList[currentCalendarIndex].calendarName),
              ),
<<<<<<< HEAD
              /* body: Container(
                child: FutureBuilder(
                  future: eventDependency.getEventList(
                      id: calendarList[currentCalendarIndex].calendarId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          //Call event data service
                          itemCount: 1 +
                              getEventList(
                                      eventList, _controller.selectedDay, time)
                                  .length,
                          separatorBuilder: (_, index) => Divider(),
                          itemBuilder: (_, index) {
                            List<Event> tempCalendarList = getEventList(
                                eventList, _controller.selectedDay, time);
                            if (index == 0) {
                              return TableCalendar(
                                availableCalendarFormats: {
                                  CalendarFormat.month: 'Month'
                                },
                                calendarController: _controller,
                                calendarStyle: CalendarStyle(
                                    contentDecoration: BoxDecoration(
                                      color: calendarList[currentCalendarIndex]
                                          .color,
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
                                      tempCalendarList[index - 1].eventName),
                                  onTap: () async {
                                    final respond = await Navigator.pushNamed(
                                        context, eventDetailsRoute,
                                        arguments: tempCalendarList[index - 1]);
                                    if (respond != null) {
                                      setState(() {});
                                    }
                                  });
                            }
                          });
                    } else {
                      return Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(height: 50),
                              Text('Fetching data... Please wait'),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              */
=======
              body: Container(
                  child: FutureBuilder(
                future: eventDependency.getEventList(
                    c: calendarList[currentCalendarIndex],
                    date: _controller.selectedDay,
                    currentTime: time),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        //Call event data service
                        itemCount: 1 + snapshot.data.length,
                        separatorBuilder: (_, index) => Divider(),
                        itemBuilder: (_, index) {
                          List<Event> tempCalendarList = snapshot.data;
                          if (index == 0) {
                            return TableCalendar(
                              availableCalendarFormats: {
                                CalendarFormat.month: 'Month'
                              },
                              calendarController: _controller,
                              calendarStyle: CalendarStyle(
                                  contentDecoration: BoxDecoration(
                                    color: calendarList[currentCalendarIndex]
                                        .color,
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
                                title:
                                    Text(tempCalendarList[index - 1].eventName),
                                onTap: () async {
                                  final respond = await Navigator.pushNamed(
                                      context, eventDetailsRoute,
                                      arguments: tempCalendarList[index - 1]);
                                  if (respond != null) {
                                    setState(() {});
                                  }
                                });
                          }
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )),
>>>>>>> remotes/origin/backend-kaixian
              drawer: Drawer(
                elevation: 20.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: DrawerHeader(
                          padding: EdgeInsets.only(top: 20, bottom: 0),
                          margin: EdgeInsets.only(top: 0, bottom: 0),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () async {
                                final respond = await Navigator.pushNamed(
                                    context, userProfileRoute);
                                if (respond != null) {
                                  setState(() {});
                                }
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/me.jpg'),
                                maxRadius: 40,
                              ),
                            ),
                            title: Text("${user.name}\n",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            subtitle: Text("${user.email}",
                                style: TextStyle(fontSize: 10)),
                          ),
                        ),
                      ),
                      BuildText("Calendar List"),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: calendarList.length,
                          separatorBuilder: (context, index) =>
                              Divider(color: Colors.black),
                          itemBuilder: (context, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/calendar.png'),
                              maxRadius: 30,
                            ),
                            title: Text(calendarList[index].calendarName),
                            onTap: () {
                              setState(() {
                                currentCalendarIndex = index;
                              });
                              Navigator.pop(context);
                            },
                            trailing: OutlineButton(
                              child: Icon(Icons.delete),
                              onPressed: () async {
                                if (calendarList.length > 1) {
                                  await calendarDependency.deleteCalendar(
                                      c: calendarList[index]);
                                  calendarList.removeAt(index);
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      BuildText("Shared with me"),
                      Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: collaboratorCalendarList.length,
                            separatorBuilder: (context, index) =>
                                Divider(color: Colors.black),
                            itemBuilder: (context, index) {
                              if (index != 0) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/calendar.png'),
                                    maxRadius: 30,
                                  ),
                                  title: Text(collaboratorCalendarList[index]
                                      .calendarName),
                                  onTap: () {
                                    setState(() {
                                      //currentCalendarIndex = index;
                                    });
                                    Navigator.pop(context);
                                  },
                                  trailing: OutlineButton(
                                    child: Icon(Icons.delete),
                                    onPressed: () async {
                                      if (collaboratorCalendarList.length > 1) {
                                        await calendarDependency.deleteCalendar(
                                            c: collaboratorCalendarList[index]);
                                        collaboratorCalendarList
                                            .removeAt(index);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                );
                              } else {
                                return Center(
                                    child: Text(
                                        "No calendar is shared with you."));
                              }
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () async {
                            await Navigator.pushNamed(
                                context, calendarCreateRoute);
                            setState(() {});
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogoutScreen()));
                          },
                          child: Text("Logout",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        ),
                      ),
                    ]),
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.black54,
                currentIndex: _currentIndex,
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
                onTap: (index) async {
                  _currentIndex = index;
                  if (index == 1) {
                    final response = await Navigator.pushNamed(
                        context, eventSummaryRoute,
                        arguments: calendarList[currentCalendarIndex]);
                    if (response != null) {
                      setState(() {});
                    }
                  } else if (index == 2) {
                    final response = await Navigator.pushNamed(
                        context, calendarCollaboratorRoute,
                        arguments: [calendarList[currentCalendarIndex], user]);
                  } else if (index == 3) {
                    final response = await Navigator.pushNamed(
                        context, eventCreateRoute, arguments: [
                      calendarList[currentCalendarIndex].eventList,
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
                            calendarList[currentCalendarIndex].eventList);
                  } else if (index == 5) {
                    final response = await Navigator.pushNamed(
                        context, calendarSettingsRoute,
                        arguments: calendarList[currentCalendarIndex]);
                    if (response != null) {
                      setState(() {});
                    }
                  }
                },
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Calendar on Loading..."),
                leading: Container(),
              ),
              body: Center(child: CircularProgressIndicator()),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.black54,
                currentIndex: _currentIndex,
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

class BuildText extends StatelessWidget {
  final text;
  const BuildText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

List<Event> getEventList(dynamic c, DateTime date, DateTime currentTime) {
  String todayDate = DateFormat('yyyy-MM-dd').format(currentTime);
  String selectedDate = DateFormat('yyyy-MM-dd').format(date);
  List<Event> event = [];
  if (selectedDate == null) {
    for (int i = 0; i < c.length; i++) {
      if (c[i].calendar == todayDate) {
        event.add(c[i]);
      }
    }
  } else if (c == null) {
    return event;
  } else {
    for (int i = 0; i < c.length; i++) {
      if (c[i].calendar == selectedDate) {
        event.add(c[i]);
      }
    }
  }
  return event;
}
