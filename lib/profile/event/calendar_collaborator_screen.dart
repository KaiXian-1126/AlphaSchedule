import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
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
  @override
  Widget build(BuildContext context) {
    Calendar c =
        Provider.of<ValueNotifier<Calendar>>(context, listen: false).value;
    User owner = Provider.of<ValueNotifier<User>>(context, listen: false).value;
    return Scaffold(
      appBar: AppBar(
        title: Text("${c.calendarName}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (_, index) => Divider(),
        itemCount: c.membersId.length + 3,
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
              title: Text("Member (${c.membersId.length})"),
            );
          if (index == c.membersId.length + 2) {
            return Column(
              children: [
                ListTile(
                  title: Text("Share Calendar"),
                ),
                Divider(),
                ListTile(
                  leading: Text("Accessibility:"),
                  title: DropdownButton(
                    onChanged: (e) {
                      setState(() {
                        c.accessibility = e;
                      });
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
                        setState(() {
                          c.membersId.add(res);
                        });
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
              onPressed: () {
                c.membersId.removeAt(index - 2);
                setState(() {});
              },
            ),
            title: Text(c.membersId[index - 2].name),
            subtitle: Text(c.membersId[index - 2].email),
          );
        },
      ),
    );
  }
}
