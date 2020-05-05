import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../providers/patients.dart';
import '../widgets/groups_list_item.dart';
import '../screens/admin_group_detail_screen.dart';

// import './group_list_item.dart';

class GroupsList extends StatefulWidget {
  final optionalMdtWorker;

  GroupsList([this.optionalMdtWorker]);

  @override
  _GroupsListState createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList> {
  @override
  Widget build(BuildContext context) {
    final patientsProvider = Provider.of<Patients>(context);
    final mdtSubsetGroups = widget.optionalMdtWorker != null;

    List<Group> subsetGroups;

    if (mdtSubsetGroups) {
      subsetGroups =
          patientsProvider.findGroupsByMdtId(widget.optionalMdtWorker.id);
    }

    //adminallgroups passes no args
    return mdtSubsetGroups
        ? subsetGroups.isEmpty
            ? Center(
                child: Text(
                'No Assigned Groups',
                textAlign: TextAlign.center,
              ))
            : Container(
                child: ListView.separated(
                  itemCount: subsetGroups.length,
                  itemBuilder: (_, i) => ChangeNotifierProvider.value(
                    value: subsetGroups[i],
                    child: GestureDetector(
                      child: ListTile(
                        leading: Icon(Icons.group),
                        title: Text(subsetGroups[i].name),
                      ),
                      onTap: () => Navigator.of(context).pushNamed(
                        AdminGroupDetailScreen.routeName,
                        arguments: subsetGroups[i].id,
                      ),
                    ),
                  ),
                  separatorBuilder: (_, i) => const Divider(),
                ),
              )
        : Container(
            child: ListView.separated(
              itemCount: patientsProvider.groups.length,
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                value: patientsProvider.groups[i],
                child: GroupsListItem(),
              ),
              separatorBuilder: (_, i) => const Divider(),
            ),
          );
  }
}
