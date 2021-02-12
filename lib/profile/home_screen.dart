import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:flutter/foundation.dart';
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
  List calendarList, collaboratorCalendarList, eventList = [];

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ValueNotifier<User>>(context).value;
    Provider.of<ValueNotifier<User>>(context).value = user;

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

            List<Calendar> calendars = [];
            calendarList.forEach((e) {
              calendars.add(e);
            });
            collaboratorCalendarList.forEach((e) {
              calendars.add(e);
            });
            Provider.of<ValueNotifier<Calendar>>(context).value =
                calendars[currentCalendarIndex];

            return Scaffold(
              appBar: AppBar(
                title: Text(calendars[currentCalendarIndex].calendarName),
              ),
              body: Container(
                child: FutureBuilder(
                  future: Future.wait([
                    eventDependency.getEventList(
                        c: calendars[currentCalendarIndex],
                        date: _controller.selectedDay,
                        currentTime: time),
                    eventDependency.getEventList(
                        c: calendars[currentCalendarIndex])
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //Store all events
                      Provider.of<ValueNotifier<List<Event>>>(context,
                              listen: false)
                          .value = snapshot.data[1];
                      return ListView.separated(
                        //Call event data service
                        itemCount: 1 + snapshot.data[0].length,
                        separatorBuilder: (_, index) => Divider(),
                        itemBuilder: (_, index) {
                          List<Event> dayEventList = snapshot.data[0];
                          if (index == 0) {
                            return TableCalendar(
                              availableCalendarFormats: {
                                CalendarFormat.month: 'Month'
                              },
                              calendarController: _controller,
                              calendarStyle: CalendarStyle(
                                  contentDecoration: BoxDecoration(
                                    color:
                                        calendars[currentCalendarIndex].color,
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
                                title: Text(dayEventList[index - 1].eventName),
                                trailing: IconButton(
                                  icon: Icon(Icons.cancel_rounded),
                                  onPressed: () async {
                                    await eventDependency.deleteEvent(
                                        id: dayEventList[index - 1].eventId);
                                    dayEventList.removeAt(index - 1);
                                    setState(() {});
                                  },
                                ),
                                onTap: () async {
                                  final respond = await Navigator.pushNamed(
                                      context, eventDetailsRoute,
                                      arguments: dayEventList[index - 1]);
                                  if (respond != null) {
                                    setState(() {});
                                  }
                                });
                          }
                        },
                      );
                    } else {
                      return ListView(children: [
                        TableCalendar(
                          availableCalendarFormats: {
                            CalendarFormat.month: 'Month'
                          },
                          calendarController: _controller,
                          calendarStyle: CalendarStyle(
                              contentDecoration: BoxDecoration(
                                color: calendars[currentCalendarIndex].color,
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
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(child: CircularProgressIndicator()))
                      ]);
                    }
                  },
                ),
              ),
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
                                child: Icon(
                                  Icons.portrait,
                                  size: 30,
                                ),
                                radius: 50,
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
                            title: Text(calendars[index].calendarName),
                            onTap: () {
                              currentCalendarIndex = index;
                              final calendarProvider =
                                  Provider.of<ValueNotifier<Calendar>>(context,
                                      listen: false);
                              calendarProvider.value = calendars[index];

                              setState(() {});
                              Navigator.pop(context);
                            },
                            trailing: OutlineButton(
                              child: Icon(Icons.delete),
                              onPressed: () async {
                                if (calendarList.length > 1) {
                                  await calendarDependency.deleteCalendar(
                                      c: calendars[index]);
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
                              if (collaboratorCalendarList.length != 0) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/calendar.png'),
                                    maxRadius: 30,
                                  ),
                                  title: Text(
                                      calendars[calendarList.length + index]
                                          .calendarName),
                                  onTap: () {
                                    setState(() {
                                      currentCalendarIndex =
                                          calendarList.length + index;
                                      final calendarProvider =
                                          Provider.of<ValueNotifier<Calendar>>(
                                              context,
                                              listen: false);
                                      calendarProvider.value = calendars[
                                          calendarList.length + index];
                                    });
                                    Navigator.pop(context);
                                  },
                                  trailing: OutlineButton(
                                    child: Icon(Icons.delete),
                                    onPressed: () async {
                                      if (collaboratorCalendarList.length > 1) {
                                        await calendarDependency.deleteCalendar(
                                            c: calendars[
                                                calendarList.length + index]);
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
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today), label: "Summary"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.share), label: "Share"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), label: "Create"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: "Search"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings"),
                ],
                onTap: (index) async {
                  _currentIndex = index;
                  if (index == 1) {
                    final response =
                        await Navigator.pushNamed(context, eventSummaryRoute);
                    if (response != null) {
                      setState(() {});
                    }
                  } else if (index == 2) {
                    final response = await Navigator.pushNamed(
                        context, calendarCollaboratorRoute,
                        arguments: [calendarList[currentCalendarIndex], user]);
                  } else if (index == 3) {
                    final response = await Navigator.pushNamed(
                        context, eventCreateRoute,
                        arguments: [_controller.selectedDay]);

                    setState(() {});
                  } else if (index == 4) {
                    Navigator.pushNamed(context, eventSearchRoute);
                  } else if (index == 5) {
                    final response = await Navigator.pushNamed(
                        context, calendarSettingsRoute,
                        arguments: calendarList[currentCalendarIndex]);
                    setState(() {});
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
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today), label: "Summary"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.share), label: "Share"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), label: "Create"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: "Search"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings"),
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
