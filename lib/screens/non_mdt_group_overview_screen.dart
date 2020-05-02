import 'package:FlutterFYP/providers/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';

class NonMdtGroupOverviewScreen extends StatelessWidget {
  static const routeName = '/non-mdt-group-overview-screen';
  @override
  Widget build(BuildContext context) {
    final _groupId = ModalRoute.of(context).settings.arguments as int;
    final _group = Provider.of<Patients>(context).findNonMdtGroupById(_groupId);
    // findGroupById(_groupId);

    return Scaffold(
      appBar: AppBar(
        title: Text(_group.name),
      ),
      body: Center(
        child: Text(_group.name),
      ),
    );
  }
}
