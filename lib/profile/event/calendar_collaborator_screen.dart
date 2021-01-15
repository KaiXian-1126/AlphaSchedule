import 'package:flutter/material.dart';
import '../../constants.dart';

class CalendarCollaboratorScreen extends StatefulWidget {
  final calendar, calendarOwner;
  CalendarCollaboratorScreen({this.calendar, this.calendarOwner});
  @override
  _CalendarCollaboratorScreenState createState() =>
      _CalendarCollaboratorScreenState();
}

class _CalendarCollaboratorScreenState
    extends State<CalendarCollaboratorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar 1"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (_, index) => Divider(),
        itemCount: widget.calendar.members.length + 3,
        itemBuilder: (_, index) {
          if (index == 0) {
            return ListTile(
              title: Text(widget.calendarOwner.name),
              subtitle: Text(widget.calendarOwner.email),
              leading: CircleAvatar(
                child: Icon(Icons.portrait),
              ),
              trailing: Text("Creator"),
            );
          }
          if (index == 1)
            return ListTile(
              title: Text("Member (${widget.calendar.members.length})"),
            );
          if (index == widget.calendar.members.length + 2) {
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
                        widget.calendar.accessibility = e;
                      });
                    },
                    value: widget.calendar.accessibility,
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
                    onPressed: () {
                      Navigator.pushNamed(context, addCollaboratorRoute);
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
                widget.calendar.members.removeAt(index - 2);
                setState(() {});
              },
            ),
            title: Text(widget.calendar.members[index - 2].name),
            subtitle: Text(widget.calendar.members[index - 2].email),
          );
        },
      ),
    );
  }
}
