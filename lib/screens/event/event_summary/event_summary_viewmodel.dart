import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:flutter/material.dart';

class EventSummaryViewmodel extends Viewmodel {
  List<Event> events;
  EventService get dataService => dependency();

  getEventList({Calendar calendar}) async {
    turnBusy();
    events = await dataService.getEventList(c: calendar);
    turnIdle();
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

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(border: Border.all(), color: Colors.blue[100]);
  }

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

  get rebuild => notifyListeners();
}
