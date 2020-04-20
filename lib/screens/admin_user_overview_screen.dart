import 'package:FlutterFYP/widgets/my_tab_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './test_screen.dart';

class AdminUserOverviewScreen extends StatefulWidget {
  static const routeName = '/admin-user-overview-screen';

  @override
  _AdminUserOverviewScreenState createState() =>
      _AdminUserOverviewScreenState();
}

class _AdminUserOverviewScreenState extends State<AdminUserOverviewScreen> {
  final categories = {
    'All': true,
    'Excercise': true,
    'Pain': true,
    'Stress': true
  };
  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 2,
    //   child:
       return Scaffold(
          appBar: AppBar(
            title: Text('User Overview'),
          ),
          body: Center(child: Text('OVERWHO'),)
       );
  }
}
