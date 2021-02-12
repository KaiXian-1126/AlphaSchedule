import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:flutter/material.dart';
import 'package:alpha_schedule/screens/home/home_viewmodel.dart';
import 'package:alpha_schedule/screens/login/login_viewmodel.dart';
import 'package:alpha_schedule/screens/calendar/add_collaborator/add_collaborator_viewmodel.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;

import '../../view.dart';

class AddCollaboratorScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => AddCollaboratorScreen());
  @override
  _AddCollaboratorScreenState createState() => _AddCollaboratorScreenState();
}

class _AddCollaboratorScreenState extends State<AddCollaboratorScreen> {
  TextEditingController _emailController = TextEditingController();

  User invitedUser;
  List<User> users;
  final _emailFormKey = GlobalKey<FormState>();

  // check from list of user email.
  bool checkUserEmail(String email) {
    bool checkValue = false;

    for (int i = 0; i < users.length; i++) {
      if (email == users[i].email) {
        checkValue = true;
        invitedUser = users[i];
        break;
      } else {
        invitedUser = null;
        checkValue = false;
      }
    }
    return checkValue;
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(border: Border.all(), color: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    Calendar c = di.dependency<HomeViewmodel>().currentCalendar;
    users = di.dependency<LoginViewmodel>().users;
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Add Collaborator'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body:
              View<AddCollaboratorViewmodel>(builder: (context, viewmodel, _) {
            return Container(
              // set margin of body
              margin: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    child: Icon(
                      Icons.people_alt_outlined,
                      size: 154,
                      color: Colors.blue,
                    ),
                  ),
                  //Email
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.blue)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 20, bottom: 8, left: 8, right: 8),
                          child: Text(
                            "Enter Email",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.only(bottom: 15),
                          child: Form(
                            key: _emailFormKey,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "This field cannot be empty";
                                } else if (!validateEmail(value)) {
                                  return "Not a valid email";
                                } else if (!checkUserEmail(
                                    _emailController.text)) {
                                  return "Error! Unable to find this email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BuildFlatButton(
                    text: 'Add',
                    color: Colors.blue,
                    onPressedCallback: () async {
                      // form validation
                      if (_emailFormKey.currentState.validate()) {
                        viewmodel.addCalendarCollaborator(
                            calendar: c, member: invitedUser);

                        // String res = result.membersId[result.membersId.length - 1];
                        // Navigator.pop(context, res);
                        Navigator.pop(context, invitedUser);
                      }
                    },
                  ),
                ],
              ),
            );
          })),
    );
  }
}

bool validateEmail(String email) {
  RegExp validation = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return (!validation.hasMatch(email)) ? false : true;
}

class BuildFlatButton extends StatelessWidget {
  final text, color, onPressedCallback;
  const BuildFlatButton(
      {this.text, this.color: Colors.grey, this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3, right: 3, top: 23, bottom: 50),
      height: 50,
      child: FlatButton(
        color: color,
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onPressedCallback,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
