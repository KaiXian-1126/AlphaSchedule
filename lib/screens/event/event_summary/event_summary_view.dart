import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/event/event_detail/event_detail_viewmodel.dart';
import 'package:alpha_schedule/screens/event/event_summary/event_summary_viewmodel.dart';
import 'package:alpha_schedule/screens/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../view.dart';

class EventSummaryScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => EventSummaryScreen());

  @override
  _EventSummaryScreenState createState() => _EventSummaryScreenState();
}

class _EventSummaryScreenState extends State<EventSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    List<String> onComingEvent2;
    List<Event> eventList;
    bool assigned = false;

    Calendar c = dependency<HomeViewmodel>().currentCalendar;
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
        body: View<EventSummaryViewmodel>(
          initViewmodel: (viewmodel) => viewmodel.getEventList(calendar: c),
          builder: (context, viewmodel, _) {
            if (!assigned) {
              eventList = viewmodel.events;
              onComingEvent2 = viewmodel.getOnComing2(todayDate, eventList);
              assigned = true;
            }
            return ListView(
              children: [
                Container(
                  decoration: viewmodel.myBoxDecoration(),
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
                if (viewmodel.getTodayEvent(todayDate, eventList) != null)
                  myList(viewmodel.getTodayEvent(todayDate, eventList),
                      Colors.blue[100]),
                Container(
                  decoration: viewmodel.myBoxDecoration(),
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
                  myList(viewmodel.getTodayEvent(onComingEvent2[i], eventList),
                      Colors.blue[100]),
              ],
            );
          },
        ));
  }

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
                            dependency<EventDetailsViewmodel>().currentEvent =
                                a[index];
                            await Navigator.popAndPushNamed(
                                context, eventDetailsRoute);
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
