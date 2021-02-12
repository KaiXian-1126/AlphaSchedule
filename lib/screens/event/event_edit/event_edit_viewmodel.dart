import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/event/event_service.dart';

class EventEditViewmodel extends Viewmodel {
  Event events;
  EventService get dataService => dependency();

  getEvent({String id}) async {
    turnBusy();
    events = await dataService.getEvent(id: id);
    turnIdle();
  }

  updateSelectedEvent(
      {String id,
      String name,
      String startTime,
      String endTime,
      String desc}) async {
    events = await dataService.updateEvent(
        id: id, name: name, startTime: startTime, endTime: endTime, desc: desc);
  }

  get rebuild => notifyListeners();
}
