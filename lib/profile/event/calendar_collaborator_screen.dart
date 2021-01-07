import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalendarCollaboratorScreen extends StatefulWidget {
  @override
  _CalendarCollaboratorScreenState createState() =>
      _CalendarCollaboratorScreenState();
}

class _CalendarCollaboratorScreenState
    extends State<CalendarCollaboratorScreen> {
  String accessibility = "View Only",
      shareLink = "https://Calendar1/1/Sharelink.com";
  List memberList = [
    "Tan Zhi Quan",
    "Cheng Shin Wei",
    "Tan Wei Kok",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar 1"),
        leading: Icon(Icons.arrow_back),
      ),
      body: ListView.separated(
        separatorBuilder: (_, index) => Divider(),
        itemCount: memberList.length + 3,
        itemBuilder: (_, index) {
          if (index == 0) {
            return ListTile(
              title: Text("Tok Kai Xian"),
              subtitle: Text("kaixianp@gmail.com"),
              leading: CircleAvatar(
                child: Icon(Icons.portrait),
              ),
              trailing: Text("Creator"),
            );
          }
          if (index == 1)
            return ListTile(
              title: Text("Member (${memberList.length})"),
            );
          if (index == memberList.length + 2) {
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
                        accessibility = e;
                      });
                    },
                    value: accessibility,
                    items: ['View Only', 'Editable'].map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    initialValue: shareLink,
                    readOnly: true,
                  ),
                  trailing: FlatButton(
                    child: Text(
                      "Copy",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: shareLink));
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
                memberList.removeAt(index - 2);
                setState(() {});
              },
            ),
            title: Text(memberList[index - 2]),
            subtitle: Text("kaixianp@gmail.com"),
          );
        },
      ),
    );
  }
}
