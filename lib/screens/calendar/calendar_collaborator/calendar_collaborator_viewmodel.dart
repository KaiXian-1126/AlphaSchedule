import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/screens/viewmodel.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';

class CalendarCollaboratorViewmodel extends Viewmodel {
  List<User> members = [];
  CalendarService get dataService => dependency();

  updateAccessibility({Calendar c, String accessibility}) async {
    await dataService.updateAccessibility(c: c, accessibility: accessibility);
  }

  getCalendarMembers({Calendar c}) async {
    turnBusy();
    members = await dataService.getCalendarMembers(c: c);
    turnIdle();
  }

  deleteCalendarCollaborator({Calendar calendar, User member}) async {
    await dataService.deleteCalendarCollaborator(
        calendar: calendar, member: member);
  }

  get rebuild => notifyListeners();
}
