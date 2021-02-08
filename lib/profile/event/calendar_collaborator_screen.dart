import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class CalendarCollaboratorScreen extends StatefulWidget {
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
    Calendar c =
        Provider.of<ValueNotifier<Calendar>>(context, listen: false).value;
    User owner = Provider.of<ValueNotifier<User>>(context, listen: false).value;
    membersLength = c.membersId.length;
    CalendarService calendarDependency = di.dependency();
    return Scaffold(
      appBar: AppBar(
        title: Text("${c.calendarName}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
          future: calendarDependency.getCalendarMembers(c: c),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final members = snapshot.data;

              return ListView.separated(
                separatorBuilder: (_, index) => Divider(),
                itemCount: (membersLength == 0 ? 1 : membersLength) + 3,
                itemBuilder: (_, index) {
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
                      title: Text("Member ($membersLength)"),
                    );
                  if (index == (membersLength == 0 ? 1 : membersLength) + 2) {
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
                              await calendarDependency.updateAccessibility(
                                  c: c, accessibility: e);
                              setState(() {
                                c.accessibility = e;
                              });
                            },
                            value: c.accessibility,
                            items:
                                ['View Only', 'Editable'].map((String value) {
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
                                setState(() {
                                  if (c.membersId.length != 0) membersLength++;
                                  c.membersId.add(res);
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  if (membersLength == 0) {
                    return ListTile(
                      title: Text("No member in this calendar yet."),
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
                            calendar: c, member: members[index - 2]);
                        c.membersId.removeAt(index - 2);
                        membersLength--;
                        setState(() {});
                      },
                    ),
                    title: Text(members[index - 2].name),
                    subtitle: Text(members[index - 2].email),
                  );
                },
              );
            } else {
              return ListView(
                children: [
                  ListTile(
                    title: Text(owner.name),
                    subtitle: Text(owner.email),
                    leading: CircleAvatar(
                      child: Icon(Icons.portrait),
                    ),
                    trailing: Text("Creator"),
                  ),
                  Container(
                    child: Center(child: CircularProgressIndicator()),
                    height: 200,
                  )
                ],
              );
            }
          }),
    );
  }
}
