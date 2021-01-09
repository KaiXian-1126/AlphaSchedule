import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:flutter/material.dart';
import '../models/mockdata.dart';
import 'package:table_calendar/table_calendar.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<DateTime> _events;
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar 1"),
      ),
      body: Container(
        child: ListView(children: <Widget>[
          TableCalendar(
            calendarController: _controller,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 150,
            width: 300,
            child: ListView.separated(
              itemCount: event.length,
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
              itemBuilder: (context, index) => ListTile(
                title: Text(event[index].eventName),
              ),
            ),
          )
        ]),
      ),
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
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/me.jpg'),
                          maxRadius: 40,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40, left: 25),
                      child: Column(children: <Widget>[
                        Text("${mockData.name}\n",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("${mockData.email}",
                            style: TextStyle(fontSize: 10)),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30, left: 20),
                      child: Icon(Icons.edit),
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
                itemCount: calendar.length,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.black),
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/calendar.png'),
                    maxRadius: 30,
                  ),
                  title: Text(calendar[index].calendarName),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {},
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
        type: BottomNavigationBarType.fixed,
        items: [
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
