import 'package:FlutterFYP/providers/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/group.dart';
import '../providers/item.dart';
import '../screens/detailed_repo_item_screen.dart';

class RepositoryItem extends StatelessWidget {
  var adminGroupId;

  //No args when coming from RepositoryList(Patient)
  //Takes in groupId from AdminRepositoryList to share post with group
  // admingroupid == no group from regular repo list(at least mdt)
  RepositoryItem([this.adminGroupId]);
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    final itemMedia = item.media;
    final itemTitle = item.title;
    Map<String, dynamic> args =
        Provider.of<Auth>(context, listen: false).isPatient
            ? {
                "itemId": item.id,
                "groupId": Provider.of<Repository>(context).group.id
              }
            : adminGroupId == null
                ? {
                    "itemId": item.id,
                    "groupId": Provider.of<Repository>(context).group.id
                  }
                : (adminGroupId == "nogroup"
                    ? {
                        "itemId": item.id,
                      }
                    : {"itemId": item.id, "adminGroupId": adminGroupId});

    return GestureDetector(
      child: itemMedia == "video"
          ? ListTile(
              key: ValueKey(item.id),
              leading: Icon(Icons.play_circle_outline),
              title:
                  Text(itemTitle, style: Theme.of(context).textTheme.headline5),
              trailing: Text(
                item.category,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          : ListTile(
              key: ValueKey(item.id),
              leading: Icon(Icons.import_contacts),
              title:
                  Text(itemTitle, style: Theme.of(context).textTheme.headline5),
              trailing: Text(
                item.category,
                style: TextStyle(color: Colors.grey),
              ),
            ),
      onTap: () => Navigator.of(context).pushNamed(
        DetailedRepoItemScreen.routeName,
        arguments: args,
      ),
    );
  }
}
