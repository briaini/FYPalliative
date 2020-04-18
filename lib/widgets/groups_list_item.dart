import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../providers/group.dart';
import '../screens/mdt_patient_screen.dart';

class GroupsListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    final List<UserDAO> members = group.members;

    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.group),
        title: Text(group.name),
      ),
      onTap: null
      // () => Navigator.of(context).pushNamed(
      //   MdtPatientScreen.routeName,
      //   arguments: group,
      // ),
    );
  }
}
