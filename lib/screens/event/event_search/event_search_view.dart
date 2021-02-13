import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/screens/event/event_search/event_search_viewmodel.dart';
import 'package:alpha_schedule/screens/home/home_viewmodel.dart';
import 'package:alpha_schedule/screens/view.dart';
import 'package:alpha_schedule/app/dependencies.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class EventSearchScreen extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => EventSearchScreen());
  @override
  Widget build(BuildContext context) {
    List eventLists = [];
    bool assigned = false;
    Calendar c = dependency<HomeViewmodel>().currentCalendar;
    return Scaffold(
      appBar: AppBar(
        title: Text("${c.calendarName}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: View<EventSearchViewmodel>(
          initViewmodel: (viewmodel) => viewmodel.getEventList(calendar: c),
          builder: (context, viewmodel, _) {
            if (!assigned) {
              eventLists = viewmodel.events;
              assigned = true;
            }
            return Container(
              margin: EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemCount: eventLists.length + 1,
                  separatorBuilder: (_, index) => Divider(),
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      return TextFormField(
                        onChanged: (text) {
                          eventLists = viewmodel.searchEvent(text);
                          viewmodel.rebuild();
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListTile(
                        title: Text(eventLists[index - 1].eventName),
                        onTap: () => Navigator.popAndPushNamed(
                            context, eventDetailsRoute,
                            arguments: eventLists[index - 1]),
                      );
                    }
                  }),
            );
          }),
    );
  }
}
