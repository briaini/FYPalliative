import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../providers/group.dart';
import '../providers/patients.dart';
import '../screens/mdt_patient_screen.dart';
import '../screens/admin_user_overview_screen.dart';

class AdminDetailedMdtListItem extends StatelessWidget {
  AdminDetailedMdtListItem();

  @override
  Widget build(BuildContext context) {
    // final group = Provider.of<Group>(context);
    // final List<UserDAO> members = group.members;
    // final patient = members.singleWhere((member) => member.role == "PATIENT");
    final mdtUser = Provider.of<UserDAO>(context);

    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text("mdt worker"),
      ),
      onTap: 
          () => Navigator.of(context)
          .pushNamed(AdminUserOverviewScreen.routeName, arguments: mdtUser)

      //     Navigator.of(context).pushNamed(
      //   MdtPatientScreen.routeName,
      //   arguments: mdtUser,
      // ),
    );
  }
}
