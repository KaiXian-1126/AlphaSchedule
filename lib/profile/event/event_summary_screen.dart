import 'package:alpha_schedule/models/calener_task.dart';
import 'package:flutter/material.dart';

class EventSummaryScreen extends StatefulWidget {
  final _data;
  EventSummaryScreen(this._data);

  @override
  _EventSummaryScreenState createState() => _EventSummaryScreenState();
}

class _EventSummaryScreenState extends State<EventSummaryScreen> {
  List<Task> todayEvent;
  List<Task> onComingEvent;
  List<String> onComingEvent2;

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(border: Border.all(), color: Colors.grey[300]);
  }

  List<Task> getTodayEvent(String value) {
    List<Task> event = [];
    widget._data.forEach((item) {
      if (item.date.compareTo(value) == 0) event.add(item);
    });
    event.sort((a, b) => a.startTime.compareTo(b.startTime));
    return event;
  }

  List<String> getOnComing2(String value) {
    List<String> event2 = [];
    List<String> temporary = [];
    widget._data.forEach((item) {
      if (item.date.compareTo('25/12/2012') == 1) {
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
    onComingEvent2 = getOnComing2('25/12/2012');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          "Calender 1",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            decoration: myBoxDecoration(),
            child: ListTile(
              tileColor: Colors.blue,
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
          myList(getTodayEvent('25/12/2012')),
          Container(
            decoration: myBoxDecoration(),
            child: ListTile(
              tileColor: Colors.blue,
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
          ////////////////////////////////////////////////////////////////////////////
          /// oncoming listview
          for (int i = 0; i < onComingEvent2.length; i++)
            myList(getTodayEvent(onComingEvent2[i])),
        ],
      ),
    );
  }
}

// extract method for listview builder
Widget myList(List<Task> a) {
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(border: Border.all(), color: Colors.grey[300]);
  }

  return Container(
    margin: EdgeInsets.only(left: 20, bottom: 20, right: 20),
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: a.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Center(
              child: Container(child: myText(a[index].date, index)),
            ),
            Container(
                decoration: myBoxDecoration(),
                child: Card(
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
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

Widget myText(String a, index) {
  if (index == 0) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 20, top: 12, bottom: 12),
      child: Text(
        "$a   Friday",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
  return null;
}
