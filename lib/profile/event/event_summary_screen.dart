import 'package:alpha_schedule/models/calener_task.dart';
import 'package:alpha_schedule/services/calendar/calendar_service_mock.dart';
import 'package:alpha_schedule/services/user/user_service_mock.dart';
import 'package:flutter/material.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

class EventSummaryScreen extends StatefulWidget {
  final bgColor;
  EventSummaryScreen(this.bgColor);

  @override
  _EventSummaryScreenState createState() => _EventSummaryScreenState();
}

class _EventSummaryScreenState extends State<EventSummaryScreen> {
  String todayDate;
  List<Task> todayEvent;
  List<String> onComingEvent2;
  CalendarServiceMock dependency = di.dependency();
  UserServiceMock user = di.dependency();

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(border: Border.all(), color: widget.bgColor[100]);
  }

  String getTodayDate() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    String month = dateParse.month.toString();
    String day = dateParse.day.toString();
    if (month.length != 2) {
      month = "0$month";
    }
    if (day.length != 2) {
      day = "0$day";
    }
    String a = ("${dateParse.year}-$month-$day");
    return a;
  }

  List<Task> getTodayEvent(String value) {
    List<Task> event = [];
    dependency.getTaskList().forEach((item) {
      if (item.date.compareTo(value) == 0) event.add(item);
    });
    event.sort((a, b) => a.startTime.compareTo(b.startTime));
    return event;
  }

  // To get list of task's date that greater than today's date without repeat same date
  List<String> getOnComing2(String value) {
    List<String> event2 = [];
    List<String> temporary = [];
    dependency.getTaskList().forEach((item) {
      if (item.date.compareTo(todayDate) > 0) {
        temporary.add(item.date);
      }
    });
    // use to set to remove duplicate date
    event2 = temporary.toSet().toList();
    event2.sort((a, b) => a.compareTo(b));
    return event2;
  }

  @override
  void initState() {
    super.initState();
    todayDate = getTodayDate();
    onComingEvent2 = getOnComing2(todayDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Calender 1",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: widget.bgColor,
      ),
      body: ListView(
        children: [
          Container(
            decoration: myBoxDecoration(),
            child: ListTile(
              tileColor: widget.bgColor[300],
              title: Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          myList(getTodayEvent(todayDate.toString()), widget.bgColor[100]),
          Container(
            decoration: myBoxDecoration(),
            child: ListTile(
              tileColor: widget.bgColor[300],
              title: Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'On Coming',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),

          /// oncoming listview
          for (int i = 0; i < onComingEvent2.length; i++)
            myList(getTodayEvent(onComingEvent2[i]), widget.bgColor[100]),
        ],
      ),
    );
  }
}

// extract method for listview builder
Widget myList(List<Task> a, Color color) {
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(border: Border.all(), color: Colors.grey[300]);
  }

  return Container(
    margin: EdgeInsets.only(left: 20, bottom: 20, right: 20),
    child: ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: a.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Center(
              child:
                  Container(child: myText(a[index].date, a[index].day, index)),
            ),
            Container(
                decoration: myBoxDecoration(),
                child: Card(
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(color: color),
                      child: Container(
                        width: 120,
                        child: Text(
                          '${a[index].startTime}' +
                              "\nto\n" +
                              '${a[index].endTime}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    title: Text(
                      a[index].title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )),
          ],
        );
      },
    ),
  );
}

Widget myText(String date, String day, index) {
  if (index == 0) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 20, top: 12, bottom: 12),
      child: Text(
        "$date   $day",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
  return null;
}
