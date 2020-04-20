import 'package:FlutterFYP/screens/admin_all_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../providers/group.dart';
import '../providers/patients.dart';
import '../screens/mdt_patient_screen.dart';
import '../screens/admin_user_overview_screen.dart';

class UserListItem extends StatelessWidget {
  Map<String, dynamic> args;

  UserListItem(this.args);

  @override
  Widget build(BuildContext context) {
    // final group = Provider.of<Group>(context);
    // final List<UserDAO> members = group.members;
    // final patient = members.singleWhere((member) => member.role == "PATIENT");
    final user = Provider.of<UserDAO>(context);

    final fromDrawer = args.containsKey('fromdrawer') ?? 0;

    print('fromVlaue: $fromDrawer');

    return GestureDetector(
        child: ListTile(
          leading: Icon(fromDrawer ? Icons.person : Icons.person_add),
          title: Text(user.name),
        ),
        onTap: fromDrawer
            ? () => Navigator.of(context)
                .pushNamed(AdminUserOverviewScreen.routeName)
            : () {
                showDialog(
                  //returning showDialog returns Future for us
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text(
                        'Do you want to add user (${user.id}) to group ${args['groupId']}?'),
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
                          Provider.of<Patients>(context, listen: false)
                              .linkUserToGroup(args['groupId'], user.id);
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
