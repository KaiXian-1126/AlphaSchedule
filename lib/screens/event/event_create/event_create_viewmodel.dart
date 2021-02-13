import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/home/home_viewmodel.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/event/event_service.dart';

class EventCreateViewmodel extends Viewmodel {
  List<Event> events = [];
  EventService get dataService => dependency();

  createEvent({String id, Event event}) async {
    turnBusy();
    final e = await dataService.createEvent(id: id, event: event);
    turnIdle();
    dependency<HomeViewmodel>().dayEvents.add(e);
    return e;
  }

  get rebuild => notifyListeners();
}
