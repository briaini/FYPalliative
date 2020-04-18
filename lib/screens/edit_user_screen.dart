import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserScreen extends StatefulWidget {
  static const routeName = '/edit-user-screen';
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Container(child: Text('EDIT USER')
          //   ListView(
          //     children: <Widget>[
          //       Form(
          //           child: Column(
          //         children: <Widget>[],
          //       ))
          //     ],
          //   ),
          ),
    );
  }
}
