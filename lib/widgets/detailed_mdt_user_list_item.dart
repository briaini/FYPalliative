import 'package:FlutterFYP/screens/admin_read_groups_screen.dart';
import 'package:FlutterFYP/screens/edit_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../providers/patients.dart';
import '../screens/mdt_patient_screen.dart';

class DetailedMdtUserListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mdtWorker = Provider.of<UserDAO>(context);
    return GestureDetector(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(mdtWorker.name),
        ),
        onTap: () => Navigator.of(context)
            .pushNamed(AdminReadGroupsScreen.routeName, arguments: mdtWorker),
        onLongPress: () => Provider.of<Patients>(context)
            .adminFetchUser(mdtWorker.id)
            .then((value) => Navigator.of(context)
                .pushNamed(EditUserScreen.routeName, arguments: value))
        //  print(value))
        // Navigator.of(context).pushNamed(EditUserScreen.routeName, arguments: mdtWorker.id),
        );
  }
}
