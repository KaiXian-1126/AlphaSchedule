import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';

class CalendarCreateViewmodel extends Viewmodel {
  CalendarService get dataService => dependency();

  createCalendar({String id, Calendar data}) async {
    turnBusy();
    await dataService.createCalendar(id: id, data: data);
    turnIdle();
  }

  get rebuild => notifyListeners();
}
