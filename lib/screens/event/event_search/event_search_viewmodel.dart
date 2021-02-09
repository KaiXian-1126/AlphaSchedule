import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/event/event_service.dart';

class EventSearchViewmodel extends Viewmodel {
  List<Event> events;
  EventService get dataService => dependency();

  getEventList({Calendar calendar}) async {
    turnBusy();
    events = await dataService.getEventList(c: calendar);
    turnIdle();
  }

  List<Event> searchEvent(String text) {
    List<Event> matchEvents = [];
    events.forEach((e) {
      if (text.length <= e.eventName.length) {
        if ((text.toUpperCase() ==
            e.eventName.substring(0, text.length).toUpperCase())) {
          matchEvents.add(e);
        }
      }
    });
    return matchEvents;
  }

  get rebuild => notifyListeners();
}
