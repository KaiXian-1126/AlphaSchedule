import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';

import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/user/user_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarCreateScreen extends StatefulWidget {
  final calendar;
  CalendarCreateScreen({this.calendar});

  @override
  _CalendarCreateScreenState createState() => _CalendarCreateScreenState();
}

class _CalendarCreateScreenState extends State<CalendarCreateScreen> {
  String calendarName;
  String calendarDescription;
  List<Color> _colorTheme = [Colors.blue[50], Colors.green[50]];
  Color _currentColor = Colors.blue[50];
  //TextEditingController calendarNameController = TextEditingController(), descriptionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  CalendarService calendarDependency = di.dependency();
  Widget _buildCalendarName() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: TextFormField(
        //controller: calendarNameController,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Calendar name is required";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          calendarName = value;
        },
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: TextFormField(
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Description is required";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          calendarDescription = value;
        },
      ),
    );
  }

  Widget _buildThemeColor() {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          elevation: 2,
          icon: Icon(Icons.arrow_drop_down),
          isExpanded: true,
          value: Colors.blue[50],
          onChanged: (value) => setState(
            () => _currentColor = value,
          ),
          items: _colorTheme.map((value) {
            return DropdownMenuItem(
                value: value,
                child: (value == Colors.blue[50])
                    ? Text("Light blue")
                    : Text("Light green"));
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Create Calendar'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                BuildText("Calendar Name"),
                _buildCalendarName(),
                BuildText("Description"),
                _buildDescription(),
                BuildText("Theme Color"),
                _buildThemeColor(),
                SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    children: [
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();

                            /* Mock Calendar
                            widget.calendar.add(Calendar(
                                calendarName: calendarName,
                                description: calendarDescription,
                                color: _currentColor,
                                eventList: [],
                                membersId: []));
                            */

                            //Mock to get a user/////////////////////////
                            User user =
                                Provider.of<ValueNotifier<User>>(context).value;

                            /////////////////////////////////////////////
                            Calendar newCalendar = Calendar(
                                calendarName: calendarName,
                                description: calendarDescription,
                                color: _currentColor,
                                accessibility: "Editable",
                                ownerId: "",
                                eventList: [],
                                membersId: []);
                            final calendar =
                                await calendarDependency.createCalendar(
                                    id: "${user.userId}", data: newCalendar);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class BuildText extends StatelessWidget {
  final text;
  const BuildText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20, right: 30),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
