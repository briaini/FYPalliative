import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/groups_list_item.dart';

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
    return widget.optionalMdtWorker == null
        ? Container(
            child: ListView.separated(
              itemCount: patientsProvider.groups.length,
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                value: patientsProvider.groups[i],
                child: GroupsListItem(),
              ),
              separatorBuilder: (_, i) => const Divider(),
            ),
          )
        : Container(
            child: ListView.separated(
              itemCount: patientsProvider
                  .findGroupsByMdtId(widget.optionalMdtWorker.id)
                  .length,
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                value:
                    patientsProvider.findGroupsByMdtId(widget.optionalMdtWorker.id)[i],
                child: GroupsListItem(),
              ),
              separatorBuilder: (_, i) => const Divider(),
            ),
          );
  }
}
