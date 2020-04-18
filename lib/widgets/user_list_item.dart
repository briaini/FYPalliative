import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../providers/group.dart';
import '../screens/mdt_patient_screen.dart';

class UserListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final group = Provider.of<Group>(context);
    // final List<UserDAO> members = group.members;
    // final patient = members.singleWhere((member) => member.role == "PATIENT");
    final user = Provider.of<UserDAO>(context);

    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.healing),
        title: Text(user.name),
      ),
      onTap: () => print(user.name)
      // Navigator.of(context).pushNamed(
      //   MdtPatientScreen.routeName,
        // arguments: group,
      // ),
    );
  }
}
