import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../screens/detailed_repo_item_screen.dart';

class RepositoryItem extends StatelessWidget {
  var adminGroupId;

  RepositoryItem([this.adminGroupId]);
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    final itemMedia = item.media;
    final itemTitle = item.title;
    print('test in repositoryItem: $adminGroupId');
    Map<String, dynamic> args =
        adminGroupId == null ? {"item": item} : {"item": item, "submarine": adminGroupId};

    return GestureDetector(
      child: itemMedia == "video"
          ? ListTile(
              leading: Icon(Icons.play_circle_outline),
              title:
                  Text(itemTitle, style: Theme.of(context).textTheme.headline5),
            )
          : ListTile(
              leading: Icon(Icons.import_contacts),
              title:
                  Text(itemTitle, style: Theme.of(context).textTheme.headline5),
            ),
      onTap: () => Navigator.of(context).pushNamed(
        DetailedRepoItemScreen.routeName,
        arguments: args,
      ),
    );
  }
}
