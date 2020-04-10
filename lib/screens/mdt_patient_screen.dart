import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import '../providers/group.dart';
import '../widgets/mdt_patient_shared_repo.dart';
import '../widgets/mdt_overview.dart';


class MdtPatientScreen extends StatelessWidget {
  static const routeName = '/mdt-patient-screen';
  @override
  Widget build(BuildContext context) {
    // final patient = Provider.of<Patient>(context);
    final group = ModalRoute.of(context).settings.arguments as Group;

    return ChangeNotifierProvider.value(
      value: group,
      child: InfoWidget(),
    );
  }
}

class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(group.name),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.supervised_user_circle),
              ),
              Tab(
                icon: Icon(Icons.description),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MdtOverview(),
            MdtPatientSharedRepo(),
          ],
        ),
      ),
    );
  }
}
