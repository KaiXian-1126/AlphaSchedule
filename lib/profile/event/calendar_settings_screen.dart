import 'package:flutter/material.dart';
import '../../models/mockdata.dart';

class CalendarSettingScreen extends StatefulWidget {
  @override
  _CalendarSettingScreenState createState() => _CalendarSettingScreenState();
}

class _CalendarSettingScreenState extends State<CalendarSettingScreen> {
  String calendarName;
  String calendarDescription;
  List<Color> _colorTheme = [Colors.blue, Colors.red];

  final _formkey = GlobalKey<FormState>();

  Widget _buildCalendarName() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: TextFormField(
        initialValue: "${calendar[1].calendarName}",
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
        initialValue: "${calendar[1].description}",
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
          value: calendar[1].color,
          onChanged: (value) => setState(() => calendar[1].color = value),
          items: _colorTheme.map((value) {
            return DropdownMenuItem(
                value: value,
                child: (value == Colors.red) ? Text("red") : Text("blue"));
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: calendar[1].color,
          title: Text('Calendar Setting'),
          leading: Icon(Icons.arrow_back),
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
                      return;
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
