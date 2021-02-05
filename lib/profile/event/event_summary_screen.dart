import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../models/Event.dart';

class EventSummaryScreen extends StatefulWidget {
  final calender;

  EventSummaryScreen(this.calender);

  @override
  _EventSummaryScreenState createState() => _EventSummaryScreenState();
}

class _EventSummaryScreenState extends State<EventSummaryScreen> {
  String todayDate;
  List<Event> todayEvent;
  List<String> onComingEvent2;

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(border: Border.all(), color: Colors.blue[100]);
  }

  List<Event> getTodayEvent(String value) {
    var dateParse = DateTime.parse(value);
    List<Event> event = [];
    widget.calender.eventList.forEach((item) {
      String a = '${item.calendar}';
      if (a.compareTo(dateParse.toString()) == 0) event.add(item);
    });
    event.sort(
        (a, b) => a.startTime.toString().compareTo(b.startTime.toString()));
    return event;
  }

  // To get list of task's date that greater than today's date without repeat same date
  List<String> getOnComing2(value) {
    List<String> event2 = [];
    List<String> temporary = [];
    widget.calender.eventList.forEach((item) {
      String a = '${item.calendar}';
      if (a.compareTo(value) > 0) {
        temporary.add(a);
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
    print(widget.calender.calendarId);
    todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    onComingEvent2 = getOnComing2(todayDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context, widget.calender),
        ),
        title: Text(
          widget.calender.calendarName,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Container(
            decoration: myBoxDecoration(),
            child: ListTile(
              tileColor: Colors.blue[300],
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
          myList(getTodayEvent(todayDate), Colors.blue[100]),
          Container(
            decoration: myBoxDecoration(),
            child: ListTile(
              tileColor: Colors.blue[300],
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
            myList(getTodayEvent(onComingEvent2[i]), Colors.blue[100]),
        ],
      ),
    );
  }

// extract method for listview builder
  Widget myList(List<Event> a, Color color) {
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
                child: Container(child: myText(a[index].calendar, index)),
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
                              // "${widget.event.timeToStringConverter(widget.event.startTime)} to ${widget.event.timeToStringConverter(widget.event.endTime)}",
                              '${a[index].startTime}' +
                                  "\nto\n" +
                                  '${a[index].endTime}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        title: Text(
                          a[index].eventName,
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () async {
                          final respond = await Navigator.pushNamed(
                            context,
                            eventDetailsRoute,
                            arguments: a[index],
                          );
                          if (respond != null) {
                            setState(() {});
                          }
                        }),
                  )),
            ],
          );
        },
      ),
    );
  }
}

Widget myText(DateTime date, index) {
  //var date1 = getDate(date);
  // var day = DateFormat('EEEE').format(date);
  if (index == 0) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 20, top: 12, bottom: 12),
      child: Text(
        "$date   ",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
  return null;
}
/*
String getDate(DateTime value) {
  var dateParse = DateTime.parse(value.toString());
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
*/
