import 'package:alpha_schedule/screens/home/home_viewmodel.dart';
import 'package:alpha_schedule/screens/view.dart';
import 'package:flutter/material.dart';
import 'package:alpha_schedule/screens/calendar/calendar_setting/calendar_setting_viewmodel.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

class CalendarSettingScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => CalendarSettingScreen());

  @override
  _CalendarSettingScreenState createState() => _CalendarSettingScreenState();
}

class _CalendarSettingScreenState extends State<CalendarSettingScreen> {
  String calendarName;
  String calendarDescription;

  Color tempColor, tempColor1;
  List<Color> _colorTheme = [Colors.blue[50], Colors.green[50]];
  bool assigned = false;
  Calendar calendar = di.dependency<HomeViewmodel>().currentCalendar;
  final _formkey = GlobalKey<FormState>();

  Widget _buildCalendarName() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: TextFormField(
        initialValue: "${calendar.calendarName}",
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Calendar name is required";
          } else {
            calendarName = value;
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
        initialValue: "${calendar.description}",
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Description is required";
          } else {
            calendarDescription = value;
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
          value: calendar.color,
          onChanged: (value) => setState(() {
            tempColor = value;
          }),
          items: _colorTheme.map((value) {
            return DropdownMenuItem(
                value: value,
                child: (value == Colors.green[50])
                    ? Text("Light Green")
                    : Text("Light Blue"));
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    tempColor1 = calendar.color;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Calendar Setting'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: View<CalendarSettingViewmodel>(builder: (context, viewmodel, _) {
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
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        calendar.description = calendarDescription;
                        calendar.calendarName = calendarName;
                        if (tempColor1 != tempColor && tempColor != null) {
                          calendar.color = tempColor;
                        } else {
                          calendar.color = tempColor1;
                        }

                        if (calendar.color == Color(0xffe3f2fd)) {
                          calendar.color = Colors.blue[50];
                        } else {
                          calendar.color = Colors.green[50];
                        }
                        viewmodel.updateCalendar(
                            id: calendar.calendarId,
                            name: calendar.calendarName,
                            description: calendar.description,
                            color: calendar.color == Colors.blue[50]
                                ? "Light Blue"
                                : "Light Green");
                        Navigator.pop(context);
                      }

                      _formkey.currentState.save();
                    },
                  )
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
