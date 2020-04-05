import 'package:flutter/material.dart';

import '../providers/patient.dart';

class PatientListItem extends StatelessWidget {
  final patient;
  
  PatientListItem(this.patient);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.healing),
        title: Text(patient.name),
      ),
      onTap: null,
    );
  }
}
