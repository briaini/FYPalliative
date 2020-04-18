import 'package:FlutterFYP/screens/admin_group_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../providers/group.dart';
import '../screens/admin_group_detail_screen.dart';

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
      onTap: () => Navigator.of(context).pushNamed(
        AdminGroupDetailScreen.routeName,
        arguments: group,
      ),
    );
  }
}
