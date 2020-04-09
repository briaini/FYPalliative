import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../screens/mdt_patient_screen.dart';

class PatientsListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);

    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.healing),
        // title: Text(patient.name),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        MdtPatientScreen.routeName,
        arguments: group,
      ),
    );
  }
}
