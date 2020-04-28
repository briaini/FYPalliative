import 'package:FlutterFYP/providers/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../providers/item.dart';

class MdtAddPostList extends StatefulWidget {
  @override
  _MdtAddPostListState createState() => _MdtAddPostListState();
}

class _MdtAddPostListState extends State<MdtAddPostList> {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    final repo = Provider.of<Repository>(context);
    final groupItems = group.posts..addAll(group.hiddenposts);
    print('groupitems: ');
    groupItems.forEach((element) {
      print(element);
    });

    final groupItemIdsgroup = groupItems.map((e) => e.id).toList();

    print('dond');
    List<Item> subitems = repo.items;
    // ..removeWhere(
    //   (element) => groupItems.contains(element),
    // );

    subitems
        .forEach((element) => print(groupItemIdsgroup.contains(element.id)));
    print('finitio');
    print(subitems.length);
    subitems.removeWhere((element) => groupItemIdsgroup.contains(element.id));
    print(subitems.length);

    return Container(
        child: ListView.builder(
            itemCount: subitems.length,
            itemBuilder: (_, i) => ListTile(
                  title: Text(subitems[i].title),
                )));
  }
}
