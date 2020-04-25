import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'settings-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              child: Text('Name'),
              backgroundImage: AssetImage('assets/images/usertile16.bmp'),
            ),
            Chip(
              label: Text('Name'),
              padding: EdgeInsets.all(50),
              shape: CircleBorder(),
              avatar: Container(
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage('assets/images/usertile16.bmp'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
