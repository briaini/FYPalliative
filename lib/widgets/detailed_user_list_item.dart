import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../providers/patients.dart';
import '../screens/edit_user_screen.dart';
import '../screens/mdt_patient_screen.dart';

class DetailedUserListItem extends StatelessWidget {

  DetailedUserListItem();

  @override
  Widget build(BuildContext context) {
    // final group = Provider.of<Group>(context);
    // final List<UserDAO> members = group.members;
    // final patient = members.singleWhere((member) => member.role == "PATIENT");
    final group = Provider.of<Group>(context);
    final patient = group.members.firstWhere((element) => element.role=="PATIENT");

    return GestureDetector(
        child: ListTile(
          key: ValueKey(patient.id),
          leading: Icon(Icons.person),
          title: Text(patient.name),
        ),
        onTap:() => Navigator.of(context)
                .pushNamed(MdtPatientScreen.routeName, arguments: group.id),
                onLongPress: () => Provider.of<Patients>(context)
            .adminFetchUser(patient.id)
            .then((value) => Navigator.of(context)
                .pushNamed(EditUserScreen.routeName, arguments: value)),
            
        // Navigator.of(context).pushNamed(
        //   MdtPatientScreen.routeName,
        // arguments: group,
        // ),
        );
  }
}
