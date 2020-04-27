import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../providers/item.dart';
import '../providers/patients.dart';

import '../widgets/shared_repository_item.dart';


class MdtPatientSharedRepo extends StatefulWidget {

  @override
  _MdtPatientSharedRepoState createState() => _MdtPatientSharedRepoState();
}

class _MdtPatientSharedRepoState extends State<MdtPatientSharedRepo> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Patients>(context);
    Provider.of<Group>(context);
    final group = Provider.of<Group>(context);
    List<Item> posts = group.hiddenFilter ? group.hiddenposts : group.posts;
    

    return Container(
        child: group.posts.length == 0 ? Center(child: Text("No Group Posts"),) : ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: posts.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
              value: posts.elementAt(i), 
              child: SharedRepositoryItem()),
          separatorBuilder: (_, i) => const Divider(),
        ),
      );
  }
}
