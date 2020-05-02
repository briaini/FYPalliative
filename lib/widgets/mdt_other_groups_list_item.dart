import 'package:FlutterFYP/screens/mdt_other_groups_screen.dart';
import 'package:FlutterFYP/screens/non_mdt_group_overview_screen.dart';
import 'package:flutter/material.dart';

class MdtOtherGroupsListItem extends StatelessWidget {
  final _group;

  MdtOtherGroupsListItem(this._group);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_group.name),
      onTap: () => Navigator.of(context)
          .pushNamed(NonMdtGroupOverviewScreen.routeName, arguments: _group.id),
    );
  }
}
