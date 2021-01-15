import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/user.dart';
import 'package:alpha_schedule/services/calendar/calendar_service_mock.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

class DrawerScreen extends StatefulWidget {
  User user;

  DrawerScreen(this.user);
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int currentCalendarIndex = 0;
  CalendarController _controller;
  int _currentIndex = 0;
  CalendarServiceMock dependency = di.dependency();
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dependency.getCalendar(currentCalendarIndex).calendarName),
        backgroundColor: widget.user.calendarList[currentCalendarIndex].color,
      ),
      body: ListView.separated(
          itemCount: 1 +
              dependency
                  .getEventList(widget.user.calendarList[currentCalendarIndex])
                  .length,
          separatorBuilder: (_, index) => Divider(),
          itemBuilder: (_, index) {
            Calendar tempCalendar =
                widget.user.calendarList[currentCalendarIndex];
            if (index == 0) {
              return TableCalendar(
                calendarController: _controller,
              );
            } else {
              return ListTile(
                title: Text(dependency.getEventName(tempCalendar, index - 1)),
                onTap: () => Navigator.pushNamed(context, eventDetailsRoute,
                    arguments: dependency.getEvent(tempCalendar, index - 1)),
              );
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
                          onTap: () =>
                              Navigator.pushNamed(context, userProfileRoute),
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
                    Container(
                      margin: EdgeInsets.only(bottom: 30, left: 20),
                      child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            final response = await Navigator.pushNamed(
                                context, profileEditRoute);
                            if (response != null) {
                              setState(() {});
                            }
                          }),
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
                itemCount: dependency.getCalendarList(widget.user).length,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.black),
                itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/calendar.png'),
                      maxRadius: 30,
                    ),
                    title: Text(dependency.getCalendar(index).calendarName),
                    onTap: () {
                      setState(() {
                        currentCalendarIndex = index;
                      });
                      Navigator.pop(context);
                    }),
              ),
            ),
            FloatingActionButton(
              onPressed: () async {
                await Navigator.pushNamed(context, calendarCreateRoute);
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
      bottomNavigationBar: BottomNavigationBar(
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
                arguments:
                    widget.user.calendarList[currentCalendarIndex].color);
          } else if (index == 2) {
            final response = await Navigator.pushNamed(
                context, calendarCollaboratorRoute, arguments: [
              widget.user.calendarList[currentCalendarIndex],
              widget.user
            ]);
          } else if (index == 3) {
            final response =
                await Navigator.pushNamed(context, eventCreateRoute);
            if (response != null) {
              setState(() {
                widget.user.calendarList[currentCalendarIndex].eventList
                    .add(response);
              });
            }
          } else if (index == 4) {
            Navigator.pushNamed(context, eventSearchRoute,
                arguments:
                    widget.user.calendarList[currentCalendarIndex].eventList);
          } else if (index == 5) {
            final response = await Navigator.pushNamed(
                context, calendarSettingsRoute,
                arguments: dependency.getCalendar(currentCalendarIndex));
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
