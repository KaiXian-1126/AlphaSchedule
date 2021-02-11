import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:alpha_schedule/screens/login/login_viewmodel.dart';
import 'package:alpha_schedule/screens/home/home_viewmodel.dart';
import 'package:alpha_schedule/screens/calendar/calendar_collaborator/calendar_collaborator_viewmodel.dart';

import '../../view.dart';

class CalendarCollaboratorScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => CalendarCollaboratorScreen());
  CalendarCollaboratorScreen();
  @override
  _CalendarCollaboratorScreenState createState() =>
      _CalendarCollaboratorScreenState();
}

class _CalendarCollaboratorScreenState
    extends State<CalendarCollaboratorScreen> {
  int membersLength;
  @override
  Widget build(BuildContext context) {
    List memberLists = [];
    bool assigned = false;
    Calendar c = di.dependency<HomeViewmodel>().currentCalendar;
    User owner = di.dependency<LoginViewmodel>().user;

    CalendarService calendarDependency = di.dependency();
    return Scaffold(
      appBar: AppBar(
        title: Text("${c.calendarName}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: View<CalendarCollaboratorViewmodel>(
          initViewmodel: (viewmodel) => viewmodel.getCalendarMembers(c: c),
          builder: (context, viewmodel, _) {
            if (!assigned) {
              memberLists = viewmodel.members;
              assigned = true;
            }

            return ListView.separated(
              separatorBuilder: (_, index) => Divider(),
              itemCount: memberLists.length + 3,
              itemBuilder: (_, index) {
                print(index);

                if (index == 0) {
                  return ListTile(
                    title: Text(owner.name),
                    subtitle: Text(owner.email),
                    leading: CircleAvatar(
                      child: Icon(Icons.portrait),
                    ),
                    trailing: Text("Creator"),
                  );
                }
                if (index == 1)
                  return ListTile(
                    title: Text("Member (${memberLists.length})"),
                  );
                if (index == memberLists.length + 2) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text("Share Calendar"),
                      ),
                      Divider(),
                      ListTile(
                        leading: Text("Accessibility:"),
                        title: DropdownButton(
                          onChanged: (e) async {
                            viewmodel.updateAccessibility(
                                c: c, accessibility: e);
                            c.accessibility = e;
                            viewmodel.notifyListeners();
                            // setState(() {
                            //   c.accessibility = e;
                            // });
                          },
                          value: c.accessibility,
                          items: ['View Only', 'Editable'].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      ListTile(
                        trailing: FlatButton(
                          child: Text(
                            "Add New Member",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed: () async {
                            final res = await Navigator.pushNamed(
                                context, addCollaboratorRoute);
                            if (res != null) {
                              membersLength++;
                              c.membersId.add(res);
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.portrait),
                  ),
                  trailing: OutlineButton(
                    child: Icon(Icons.delete),
                    onPressed: () async {
                      await calendarDependency.deleteCalendarCollaborator(
                          calendar: c, member: memberLists[index - 2]);
                      c.membersId.removeAt(index - 2);
                      membersLength--;
                      setState(() {});
                    },
                  ),
                  title: Text(memberLists[index - 2].name),
                  subtitle: Text(memberLists[index - 2].email),
                );
              },
            );
            // else {
            //   return ListView(
            //     children: [
            //       ListTile(
            //         title: Text(owner.name),
            //         subtitle: Text(owner.email),
            //         leading: CircleAvatar(
            //           child: Icon(Icons.portrait),
            //         ),
            //         trailing: Text("Creator"),
            //       ),
            //       Container(
            //         child: Center(child: CircularProgressIndicator()),
            //         height: 200,
            //       )
            //     ],
            //   );
            // }
          }),
    );
  }
}
