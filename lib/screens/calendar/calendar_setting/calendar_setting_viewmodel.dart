import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';

class CalendarSettingViewmodel extends Viewmodel {
  CalendarService get dataService => dependency();

  updateCalendar(
      {String id, String name, String description, String color}) async {
    turnBusy();
    await dataService.updateCalendar(
        id: id, name: name, description: description, color: color);
    turnIdle();
  }

  get rebuild => notifyListeners();
}
