import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/groups_list_item.dart';

// import './group_list_item.dart';

class GroupsList extends StatefulWidget {
  @override
  _GroupsListState createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Patients>(
        builder: (ctx, patients, child) => Container(
              child: ListView.separated(
                itemCount: patients.groups.length,
                itemBuilder: (_, i) => ChangeNotifierProvider.value(
                  value: patients.groups[i],
                  child: GroupsListItem(),
                ),
                separatorBuilder: (_, i) => const Divider(),
              ),
            ));
  }
}
