import 'package:FlutterFYP/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class NoGroupUserScreen extends StatelessWidget {
  static const routeName = '/no-group-user-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Center(
        child: Text('No Group. Assign To Group'),
      ),
    );
  }
}
