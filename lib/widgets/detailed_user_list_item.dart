import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../providers/group.dart';
import '../providers/patients.dart';
import '../screens/mdt_patient_screen.dart';
import '../screens/admin_user_overview_screen.dart';

class DetailedUserListItem extends StatelessWidget {

  DetailedUserListItem();

  @override
  Widget build(BuildContext context) {
    // final group = Provider.of<Group>(context);
    // final List<UserDAO> members = group.members;
    // final patient = members.singleWhere((member) => member.role == "PATIENT");
    final group = Provider.of<Group>(context);

    return GestureDetector(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text("user.name"),
        ),
        onTap:() => Navigator.of(context)
                .pushNamed(AdminUserOverviewScreen.routeName, arguments: group)
            
        // Navigator.of(context).pushNamed(
        //   MdtPatientScreen.routeName,
        // arguments: group,
        // ),
        );
  }
}
