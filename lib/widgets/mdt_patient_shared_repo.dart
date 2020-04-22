import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../widgets/shared_repository_item.dart';


class MdtPatientSharedRepo extends StatefulWidget {

  @override
  _MdtPatientSharedRepoState createState() => _MdtPatientSharedRepoState();
}

class _MdtPatientSharedRepoState extends State<MdtPatientSharedRepo> {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);

    return Container(
        child: group.posts.length == 0 ? Center(child: Text("No Group Posts"),) : ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: group.posts.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
              value: group.posts.elementAt(i), 
              child: SharedRepositoryItem()),
          separatorBuilder: (_, i) => const Divider(),
        ),
      );
  }
}
