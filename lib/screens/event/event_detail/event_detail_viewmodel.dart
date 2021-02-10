import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:intl/intl.dart';

class EventDetailsViewmodel extends Viewmodel {
  Event events;
  EventService get dataService => dependency();

  getEvent({String id}) async {
    turnBusy();
    events = await dataService.getEvent(id: id);
    turnIdle();
  }

  String getDate(DateTime value) {
    return DateFormat('yyyy-MM-dd').format(value);
  }

  String getDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  get rebuild => notifyListeners();
}
