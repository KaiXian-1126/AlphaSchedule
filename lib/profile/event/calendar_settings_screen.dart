import 'package:flutter/material.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/services/calendar/calendar_service.dart';

class CalendarSettingScreen extends StatefulWidget {
  final calender;
  CalendarSettingScreen({this.calender});
  @override
  _CalendarSettingScreenState createState() => _CalendarSettingScreenState();
}

class _CalendarSettingScreenState extends State<CalendarSettingScreen> {
  String calendarName;
  String calendarDescription;
  CalendarService calendarDependency = di.dependency();

  Color tempColor, tempColor1;
  List<Color> _colorTheme = [Colors.blue[50], Colors.green[50]];

  final _formkey = GlobalKey<FormState>();

  Widget _buildCalendarName() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: TextFormField(
        initialValue: "${widget.calender.calendarName}",
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
        initialValue: "${widget.calender.description}",
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
          value: widget.calender.color,
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
    tempColor1 = widget.calender.color;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Calendar Setting'),
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
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      widget.calender.description = calendarDescription;
                      widget.calender.calendarName = calendarName;
                      if (tempColor1 != tempColor && tempColor != null) {
                        widget.calender.color = tempColor;
                      } else {
                        widget.calender.color = tempColor1;
                      }

                      if (widget.calender.color == Color(0xffe3f2fd)) {
                        widget.calender.color = Colors.blue[50];
                      } else {
                        widget.calender.color = Colors.green[50];
                      }

                      final setting = await calendarDependency.updateCalendar(
                          id: "${widget.calender.calendarId}",
                          name: widget.calender.calendarName,
                          description: widget.calender.description,
                          color: widget.calender.color == Colors.blue[50]
                              ? "Light Blue"
                              : "Light Green");

                      // final calendarList =
                      //     Provider.of<List<Calendar>>(context, listen: false);

                      // if (calendarList != null) {
                      //   for (int i = 0; i < calendarList.length; i++) {
                      //     if (widget.calender.calendarId ==
                      //         calendarList[i].calendarId) {
                      //       Calendar calendarSetting =
                      //           Provider.of<ValueNotifier<Calendar>>(context,
                      //                   listen: false)
                      //               .value;
                      //       calendarSetting = widget.calender;
                      //     }
                      //   }
                      // }

                      Navigator.pop(context);
                    }

                    _formkey.currentState.save();
                  },
                )
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
