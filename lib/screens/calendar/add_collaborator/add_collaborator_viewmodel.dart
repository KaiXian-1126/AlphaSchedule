import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';

class AddCollaboratorViewmodel extends Viewmodel {
  CalendarService get dataService => dependency();

  addCalendarCollaborator({Calendar calendar, User member}) async {
    await dataService.addCalendarCollaborator(
        calendar: calendar, member: member);
  }

  get rebuild => notifyListeners();
}
