import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patient.dart';
import '../screens/mdt_patient_screen.dart';

class PatientsListItem extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<Patient>(context);

    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.healing),
        title: Text(patient.name),
      ),
      onTap: null
      // () =>
      //  Navigator.of(context).pushNamed(
      //     MdtPatientScreen.routeName,
      //     arguments: patient,
        // ),
    );
  }
}
