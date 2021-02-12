import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/event/event_detail/event_detail_viewmodel.dart';
import 'package:alpha_schedule/screens/home/home_viewmodel.dart';
import 'package:alpha_schedule/screens/login/login_viewmodel.dart';
import 'package:alpha_schedule/screens/view.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

class DrawerScreen extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => DrawerScreen());
  @override
  Widget build(BuildContext context) {
    return WidgetView<HomeViewmodel>(
      initViewmodel: (homeViewmodel) =>
          homeViewmodel.user = di.dependency<LoginViewmodel>().user,
      builder: (context, viewmodel, _) {
        CalendarController _controller = CalendarController();
        int _currentIndex = 0;
        return View<HomeViewmodel>(
            initViewmodel: (homeViewmodel) => homeViewmodel.getCalendarList(),
            builder: (context, viewmodel, _) {
              print("building");
              return Scaffold(
                appBar: AppBar(
                  title: Text(viewmodel.currentCalendar.calendarName),
                ),
                body: Container(
                  child: ListView.separated(
                    //Call event data service
                    itemCount: 1 + viewmodel.dayEvents.length,
                    separatorBuilder: (_, index) => Divider(),
                    itemBuilder: (_, index) {
                      viewmodel.getDayEventList(_controller.selectedDay);
                      print(viewmodel.dayEvents);
                      List<Event> dayEventList = viewmodel.dayEvents;
                      if (index == 0) {
                        return TableCalendar(
                          availableCalendarFormats: {
                            CalendarFormat.month: 'Month'
                          },
                          calendarController: _controller,
                          calendarStyle: CalendarStyle(
                              contentDecoration: BoxDecoration(
                                color: viewmodel.currentCalendar.color,
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
                            viewmodel.rebuild();
                          },
                        );
                      } else {
                        return ListTile(
                          title: Text(dayEventList[index - 1].eventName),
                          trailing: IconButton(
                            icon: Icon(Icons.cancel_rounded),
                            onPressed: () async {
                              viewmodel.deleteEvent(index);
                            },
                          ),
                          onTap: () async {
                            dependency<EventDetailsViewmodel>().currentEvent =
                                dayEventList[index - 1];
                            await Navigator.pushNamed(
                                context, eventDetailsRoute);
                            viewmodel.rebuild();
                          },
                        );
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
                                    viewmodel.rebuild();
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
                              title: Text("${viewmodel.user.name}\n",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text("${viewmodel.user.email}",
                                  style: TextStyle(fontSize: 10)),
                            ),
                          ),
                        ),
                        BuildText("Calendar List"),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: viewmodel.ownCalendars.length,
                            separatorBuilder: (context, index) =>
                                Divider(color: Colors.black),
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/calendar.png'),
                                maxRadius: 30,
                              ),
                              title: Text(
                                  viewmodel.ownCalendars[index].calendarName),
                              onTap: () {
                                viewmodel.currentCalendar =
                                    viewmodel.allCalendars[index];
                                Navigator.pop(context);
                                viewmodel.rebuild();
                              },
                              trailing: viewmodel.ownCalendars.length == 1
                                  ? null
                                  : OutlineButton(
                                      child: Icon(Icons.delete),
                                      onPressed: () async {
                                        if (viewmodel.ownCalendars.length > 1) {
                                          viewmodel.deleteCalendar(index);
                                        }
                                      },
                                    ),
                            ),
                          ),
                        ),
                        BuildText("Shared with me"),
                        Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: viewmodel.collaboratorCalendars.length,
                              separatorBuilder: (context, index) =>
                                  Divider(color: Colors.black),
                              itemBuilder: (context, index) {
                                if (viewmodel.collaboratorCalendars.length !=
                                    0) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/calendar.png'),
                                      maxRadius: 30,
                                    ),
                                    title: Text(viewmodel
                                        .allCalendars[
                                            viewmodel.ownCalendars.length +
                                                index]
                                        .calendarName),
                                    onTap: () {
                                      viewmodel.currentCalendar =
                                          viewmodel.allCalendars[
                                              viewmodel.ownCalendars.length +
                                                  index];
                                      viewmodel.rebuild();
                                      Navigator.pop(context);
                                    },
                                    trailing: OutlineButton(
                                      child: Icon(Icons.delete),
                                      onPressed: () {
                                        viewmodel.removeCollaborateCalendar(
                                            viewmodel.allCalendars[
                                                viewmodel.ownCalendars.length +
                                                    index],
                                            index);
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
                              final response = await Navigator.pushNamed(
                                  context, calendarCreateRoute);

                              viewmodel.notifyListeners();
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
                        viewmodel.rebuild();
                      }
                    } else if (index == 2) {
                      final response = await Navigator.pushNamed(
                          context, calendarCollaboratorRoute, arguments: [
                        viewmodel.currentCalendar,
                        viewmodel.user
                      ]);
                    } else if (index == 3) {
                      final response = await Navigator.pushNamed(
                          context, eventCreateRoute,
                          arguments: [_controller.selectedDay]);

                      viewmodel.notifyListeners();
                    } else if (index == 4) {
                      Navigator.pushNamed(context, eventSearchRoute);
                    } else if (index == 5) {
                      final response = await Navigator.pushNamed(
                        context,
                        calendarSettingsRoute,
                      );
                      viewmodel.notifyListeners();
                    }
                  },
                ),
              );
            });
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
