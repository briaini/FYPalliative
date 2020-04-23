import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import './patients_list_item.dart';


class PatientsList extends StatefulWidget {
  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Patients>(
      builder: (ctx, patients, child) => Container(
        child: ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount: patients.mdtGroupsWithPatient.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
            value:  patients.mdtGroupsWithPatient[i],
            child: PatientsListItem(),
          ),
          separatorBuilder: (_, i) => const Divider(),
        ),
      ),
    );
  }
}
