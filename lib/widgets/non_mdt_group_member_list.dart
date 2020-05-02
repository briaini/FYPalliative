import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';

class NonMdtGroupMemberList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    final users = group.members;

    return Column(
        children: List<Widget>.generate(
      users.length,
      (i) => Card(
        child: Text(users[i].name),
      ),
    ).toList());
  }
}
