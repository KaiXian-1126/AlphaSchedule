import 'package:alpha_schedule/screens/login/login_viewmodel.dart';
import 'package:alpha_schedule/screens/view.dart';
import 'package:flutter/material.dart';
import 'package:alpha_schedule/screens/calendar/calendar_create/calendar_create_viewmodel.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/screens/home/home_viewmodel.dart';

class CalendarCreateScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => CalendarCreateScreen());
  CalendarCreateScreen();

  @override
  _CalendarCreateScreenState createState() => _CalendarCreateScreenState();
}

class _CalendarCreateScreenState extends State<CalendarCreateScreen> {
  String calendarName;
  String calendarDescription;
  List<Color> _colorTheme = [Colors.blue[50], Colors.green[50]];
  Color _currentColor = Colors.blue[50];
  final _formkey = GlobalKey<FormState>();

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
        body: View<CalendarCreateViewmodel>(builder: (context, viewmodel, _) {
          User user = di.dependency<LoginViewmodel>().user;
          return Container(
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

                              Calendar newCalendar = Calendar(
                                  calendarName: calendarName,
                                  description: calendarDescription,
                                  color: _currentColor,
                                  accessibility: "Editable",
                                  ownerId: "",
                                  eventList: [],
                                  membersId: []);
                              viewmodel.createCalendar(
                                  id: "${user.userId}", data: newCalendar);
                              di
                                  .dependency<HomeViewmodel>()
                                  .ownCalendars
                                  .add(newCalendar);
                              di
                                  .dependency<HomeViewmodel>()
                                  .allCalendars
                                  .add(newCalendar);

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
          );
        }));
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
