import 'package:flutter/material.dart';
import '../../models/mockdata.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My profile"),
          leading: Icon(Icons.arrow_back),
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
                        "${mockData.name}",
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
                      title: Text("Email: ${mockData.email}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ))),
                  ListTile(
                      title: Text("Phone: ${mockData.phone}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ))),
                  ListTile(
                      title: Text("Gender: ${mockData.gender}",
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
                    onPressed: () {},
                    child:
                        Text("Change password", style: TextStyle(fontSize: 20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Edit Profile", style: TextStyle(fontSize: 20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}