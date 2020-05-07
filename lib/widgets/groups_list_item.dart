import 'package:FlutterFYP/screens/admin_group_detail_screen.dart';
import 'package:FlutterFYP/screens/non_mdt_group_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../providers/group.dart';
import '../providers/patients.dart';
import '../screens/admin_group_detail_screen.dart';

class GroupsListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    final List<UserDAO> members = group.members;

    print('grouplistitem ${group.isMdt}');

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Patients>(context).deleteGroup(group.id);
        // Navigator.of(context)
      },
      confirmDismiss: (direction) {
        return showDialog(
          //returning showDialog returns Future for us
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to delete group?'),
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
                },
              ),
            ],
          ),
        );
        // return Future.value(true);
      },
      child: GestureDetector(
          child: ListTile(
            leading: group.isMdt ? Icon(Icons.healing) : Icon(Icons.group),
            title: Text(group.name),
          ),
          onTap: group.isMdt
              ? () => Navigator.of(context).pushNamed(
                    AdminGroupDetailScreen.routeName,
                    arguments: group.id,
                  )
              : () => Navigator.of(context).pushNamed(
                    NonMdtGroupOverviewScreen.routeName,
                    arguments: group.id,
                  )),
    );
  }
}
