import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;
import '../../models/Event.dart';

class EventSummaryScreen extends StatefulWidget {
  @override
  _EventSummaryScreenState createState() => _EventSummaryScreenState();
}

class _EventSummaryScreenState extends State<EventSummaryScreen> {
  String todayDate;
  List<Event> todayEvent;
  List<String> onComingEvent2;
  EventService eventDependency = di.dependency();

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(border: Border.all(), color: Colors.blue[100]);
  }

  List<Event> getTodayEvent(String date, eventList) {
    var dateParse = DateTime.parse(date);
    List<Event> event = [];
    eventList.forEach((item) {
      String a = '${item.calendar}';
      if (a.compareTo(dateParse.toString()) == 0) event.add(item);
    });
    if (event.length != 0) {
      event.sort(
          (a, b) => a.startTime.toString().compareTo(b.startTime.toString()));
    } else {
      event = [];
    }
    return event;
  }

  // To get list of task's date that greater than today's date without repeat same date
  List<String> getOnComing2(date, eventList) {
    var dateParse = DateTime.parse(date);
    List<String> event2 = [];
    List<String> temporary = [];
    eventList.forEach((item) {
      String a = '${item.calendar}';
      if (a.compareTo(dateParse.toString()) > 0) {
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
    todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final Calendar c =
        Provider.of<ValueNotifier<Calendar>>(context, listen: false).value;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          c.calendarName,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: eventDependency.getEventList(c: c),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              onComingEvent2 = getOnComing2(todayDate, snapshot.data);
              return ListView(
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
                //  if (getTodayEvent(todayDate, snapshot.data) != null)
                //    myList(getTodayEvent(todayDate, snapshot.data),
                //        Colors.blue[100]),
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
                //  for (int i = 0; i < onComingEvent2.length; i++)
                //    myList(getTodayEvent(onComingEvent2[i], snapshot.data),
                 //       Colors.blue[100]),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

// extract method for listview builder
  Widget myList(List<Event> a, Color color) {
    BoxDecoration myBoxDecoration() {
      return BoxDecoration(border: Border.all(), color: Colors.grey[300]);
    }

    if (a.length != 0) {
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
                                '${a[index].timeToStringConverter(a[index].startTime)}' +
                                    "\nto\n" +
                                    '${a[index].timeToStringConverter(a[index].endTime)}',
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
    } else {
      return Text('');
    }
  }
}

Widget myText(DateTime date, index) {
  var date1 = DateFormat('yyyy-MM-dd').format(date);
  var day = DateFormat('EEEE').format(date);
  if (index == 0) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 0, top: 12, bottom: 12),
      child: Text(
        "$date1     $day",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
  return null;
}
