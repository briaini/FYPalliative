import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import '../providers/patient.dart';
import '../widgets/mdt_patient_shared_repo.dart';

class MdtPatientScreen extends StatelessWidget {
  static const routeName = '/mdt-patient-screen';
  @override
  Widget build(BuildContext context) {
    // final patient = Provider.of<Patient>(context);
    final patientchange = ModalRoute.of(context).settings.arguments as Patient;

    return ChangeNotifierProvider.value(
      value: patientchange,
      child: InfoWidget(),
    );
  }
}

class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<Patient>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(patient.name),
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
            Text('hi'),
            MdtPatientSharedRepo(),
          ],
        ),
      ),
    );
  }
}
