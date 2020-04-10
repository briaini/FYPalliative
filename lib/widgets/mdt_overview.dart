import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';

class MdtOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: group.members.length,
      itemBuilder: (_, i) => ListTile(
        leading: group.members[i].role == "PATIENT"
            ? Icon(Icons.healing)
            : Icon(Icons.group),
        title: Text(group.members[i].name),
      ),
      separatorBuilder: (_, i) => const Divider(),
    );
  }
}
