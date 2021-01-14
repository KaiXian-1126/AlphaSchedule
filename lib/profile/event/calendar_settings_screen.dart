import 'package:flutter/material.dart';
import '../../app/dependencies.dart';
import '../../models/Calendar.dart';
import '../../models/mockdata.dart';

class CalendarSettingScreen extends StatefulWidget {
  final calender;
  CalendarSettingScreen({this.calender});
  @override
  _CalendarSettingScreenState createState() => _CalendarSettingScreenState();
}

class _CalendarSettingScreenState extends State<CalendarSettingScreen> {
  String calendarName;
  String calendarDescription;

  Color tempColor, tempColor1;
  List<Color> _colorTheme = [Colors.blue, Colors.red];

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
                child: (value == Colors.red) ? Text("red") : Text("blue"));
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    tempColor1 = widget.calender.color;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: widget.calender.color,
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
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      widget.calender.description = calendarDescription;
                      widget.calender.calendarName = calendarName;
                      if (tempColor1 != tempColor && tempColor != null) {
                        widget.calender.color = tempColor;
                      }

                      Navigator.pop(context, widget.calender);
                      print(tempColor);
                      print(tempColor1);
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
