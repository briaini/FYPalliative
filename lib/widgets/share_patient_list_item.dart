import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../providers/patient.dart';
import '../providers/patients.dart';

class SharePatientListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context, listen: false);
    final patient = Provider.of<Patient>(context, listen: false);
    final patientsProvider = Provider.of<Patients>(context, listen: false);
    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.healing),
        title: Text(patient.name),
      ),
      onTap: () {
        showDialog(
          //returning showDialog returns Future for us
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
                'Do you want to share post(${item.id}) with ${patient.id}:${patient.name}?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                  patientsProvider.linkPostToPatient(patient.id, item.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
