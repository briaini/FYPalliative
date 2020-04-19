import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../providers/group.dart';
import '../providers/patients.dart';
import '../screens/mdt_patient_screen.dart';

class UserListItem extends StatelessWidget {
  final groupId;

  UserListItem(this.groupId);

  @override
  Widget build(BuildContext context) {
    // final group = Provider.of<Group>(context);
    // final List<UserDAO> members = group.members;
    // final patient = members.singleWhere((member) => member.role == "PATIENT");
    final user = Provider.of<UserDAO>(context);

    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.person_add),
        title: Text(user.name),
      ),
      onTap: () {
        showDialog(
          //returning showDialog returns Future for us
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
                'Do you want to add user (${user.id}) to group $groupId?'),
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
                  // patientsProvider.linkUser(patient.id, item.id);
                  Provider.of<Patients>(context, listen: false).linkUserToGroup(groupId, user.id);
                },
              ),
            ],
          ),
        );
      }
      // Navigator.of(context).pushNamed(
      //   MdtPatientScreen.routeName,
        // arguments: group,
      // ),
    );
  }
}
