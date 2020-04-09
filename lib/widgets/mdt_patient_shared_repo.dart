import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../widgets/repository_item.dart';


class MdtPatientSharedRepo extends StatefulWidget {

  @override
  _MdtPatientSharedRepoState createState() => _MdtPatientSharedRepoState();
}

class _MdtPatientSharedRepoState extends State<MdtPatientSharedRepo> {

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);

    return Container(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: group.posts.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
              value: group.posts.elementAt(i), 
              child: RepositoryItem()),
          separatorBuilder: (_, i) => const Divider(),
        ),
      );
  }
}
