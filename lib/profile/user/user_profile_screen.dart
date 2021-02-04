import 'package:alpha_schedule/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/mockdata.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ValueNotifier<User>>(context).value;
    return Scaffold(
        appBar: AppBar(
          title: Text("My profile"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, user),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
            child: ListView(
          children: [
            Container(
                height: 270,
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  children: [
                    Container(margin: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/me.jpg'),
                            maxRadius: 80,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 100),
                            child: Icon(Icons.camera)),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        "${user.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    )
                  ],
                )),
            Container(
              margin: EdgeInsets.only(left: 30, top: 10),
              child: Column(
                children: [
                  ListTile(
                      title: Text("Email: ${user.email}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ))),
                  ListTile(
                      title: Text("Phone: ${user.phone}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ))),
                  ListTile(
                      title: Text("Gender: ${user.gender}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Column(
                children: [
                  RaisedButton(
                    onPressed: () async {
                      final response = await Navigator.pushNamed(
                          context, passwordEditRoute,
                          arguments: user);
                      if (response != null) {
                        setState(() {});
                        _alertbox(context);
                      }
                    },
                    child:
                        Text("Change password", style: TextStyle(fontSize: 20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  ButtonTheme(
                    minWidth: 195,
                    child: RaisedButton(
                      onPressed: () async {
                        final response = await Navigator.pushNamed(
                            context, profileEditRoute,
                            arguments: user);
                        if (response != null) {
                          setState(() {});
                          _alertbox(context);
                        }
                      },
                      child:
                          Text("Edit Profile", style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}

void _alertbox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Image.asset('assets/logo.png', height: 50.0, width: 50.0),
          Text('Success')
        ],
      ),
      content: Text(
        'The changes had been saved',
        // style: TextStyle(fontSize: 24),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Okay"),
        ),
      ],
    ),
  );
}
