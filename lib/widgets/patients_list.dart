import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../providers/patients.dart';
import './patients_list_item.dart';
import '../screens/mdt_patient_screen.dart';

class PatientsList extends StatefulWidget {
  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  @override
  Widget build(BuildContext context) {
    final patients = Provider.of<Patients>(context);
    final mdtGroups = patients.mdtGroupsWithPatient;
    // print(mdtGroups);
    return Container(
      child: ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: mdtGroups.length,
        itemBuilder: (_, i) => ChangeNotifierProvider.value(
          value: mdtGroups[i],
          child: GestureDetector(
            child: ListTile(
              leading: Icon(Icons.healing),
              title: Text(mdtGroups[i].name),
            ),
            onTap: () => Navigator.of(context).pushNamed(
              MdtPatientScreen.routeName,
              arguments: mdtGroups[i].id,
            ),
          ),
        ),
        separatorBuilder: (_, i) => const Divider(),
      ),
    );

    // return Consumer<Patients>(
    //   builder: (ctx, patients, child) => Container(
    //     child: ListView.separated(
    //       padding: EdgeInsets.all(8),
    //       itemCount: patients.mdtGroupsWithPatient.length,
    //       itemBuilder: (_, i) => ChangeNotifierProvider.value(
    //         value:  patients.mdtGroupsWithPatient[i],
    //         child: PatientsListItem(),
    //       ),
    //       separatorBuilder: (_, i) => const Divider(),
    //     ),
    //   ),
    // );
  }
}
