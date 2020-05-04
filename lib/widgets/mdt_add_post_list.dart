import 'package:FlutterFYP/providers/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../providers/patients.dart';
import '../providers/item.dart';

class MdtAddPostList extends StatefulWidget {
  @override
  _MdtAddPostListState createState() => _MdtAddPostListState();
}

class _MdtAddPostListState extends State<MdtAddPostList> {
  var _isLoading = false;
  
  Future<void> addPostToGroup(groupId, itemId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Patients>(context, listen: false)
          .linkPostToGroup(groupId, itemId);
      await Provider.of<Patients>(context)
          .fetchMyGroups()
          .then((_) => setState(() {
                // _isLoading = false;
                Navigator.of(context).pop();
              }));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    final repo = Provider.of<Repository>(context);
    final patientsProv = Provider.of<Patients>(context);

    // group.posts.map((e) => e.id).toList().

    // final subitems = repo.getOthers(group.posts.map((e) => e.id).toList());
    // final groupItems = group.posts..addAll(group.hiddenposts);
    // final groupItemIdsgroup = groupItems.map((e) => e.id).toList();

    // print('groupitems');
    // groupItemIdsgroup.forEach((element) {print(element);});
    // List<Item> subitems = repo.items;

    // subitems
    //     .forEach((element) => print(groupItemIdsgroup.contains(element.id)));
    // subitems.removeWhere((element) => groupItemIdsgroup.contains(element.id));
    final shareItemIds = group.allPosts.map((e) => e.id).toList();

    List<Item> unshared = [];

    repo.items.forEach(
      (element) {
        if (!shareItemIds.contains(element.id)) {
          unshared.add(element);
        }
      },
    );
    final subitems = repo.items
        .skipWhile((value) => shareItemIds.contains(value.id))
        .toList();
   
    return _isLoading
        ? CircularProgressIndicator()
        : Container(
            child: ListView.builder(
              itemCount: unshared.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(unshared[i].title),
                onTap: () {
                  showDialog(
                    //returning showDialog returns Future for us
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Are you sure?'),
                      content: Text(
                          'Do you want to share post \'${subitems[i].title}\' to \'${group.members.singleWhere((user) => user.role == 'PATIENT').name}?\''),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                        ),
                        FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                            Navigator.of(ctx).pop(true);

                              addPostToGroup(group.id, subitems[i].id).then((value) => setState((){_isLoading = false;}));
                              // .then((value) {
                              //   Navigator.of(context).pop(true);
                              //   Navigator.of(context).pop();
                              //   setState(() {});
                              // });
                            })

//                     Provider.of<Patients>(context, listen: false)
//                         .linkUserToGroup(args['groupId'], user.id)
//                         .then((value) => {
// await Provider.of<Patients>(context).fetchGroups();
//                    await  Provider.of<Patients>(context).fetchUsers();
                        // _linkUser(widget.args, user.id);
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
