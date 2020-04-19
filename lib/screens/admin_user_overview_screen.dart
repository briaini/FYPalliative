import 'package:flutter/material.dart';

class AdminUserOverviewScreen extends StatelessWidget {
  static const routeName = '/admin-user-overview-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Overview'),
      ),
      body: Center(
        child: Text('User'),
      ),
    );
  }
}
