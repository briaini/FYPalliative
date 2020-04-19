import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/item.dart';
import '../providers/patient.dart';
import '../providers/patients.dart';
import '../providers/group.dart';

class SharePatientListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final item = Provider.of<Item>(context, listen: false);
    final patientsProv = Provider.of<Patients>(context, listen: false);

    final patientsProvider = Provider.of<Patients>(context, listen: false);
    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.healing),
        title: auth.isAdmin
            ? Text(Provider.of<Group>(context, listen: false).name)
            : Text(Provider.of<Patient>(context, listen: false).name),
      ),
      onTap: () {
        showDialog(
          //returning showDialog returns Future for us
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: auth.isAdmin
                ? Text(
                    'Do you want to share post(${item.id}) with group: ${Provider.of<Group>(context, listen: false).id}')
                : Text(
                    'Do you want to share post(${item.id}) with ${Provider.of<Patient>(context, listen: false).name}?'),
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
                  auth.isAdmin
                      ? patientsProv.linkPostToGroup(
                          Provider.of<Group>(context, listen: false).id,
                          item.id)
                      : patientsProv.linkPostToPatient(
                          Provider.of<Patient>(context, listen: false).id,
                          item.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
