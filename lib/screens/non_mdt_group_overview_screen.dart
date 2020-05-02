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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_group.name),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.comment),
              ),
              Tab(
                icon: Icon(Icons.adjust),
              ),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          Text('Comments list'),
          Text('Group Overview'),
        ]),
      ),
    );
  }
}
