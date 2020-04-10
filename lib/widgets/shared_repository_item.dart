import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../providers/group.dart';
import '../screens/detailed_repo_item_screen.dart';

class SharedRepositoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context, listen: false);
    final itemMedia = item.media;
    final itemTitle = item.title;
    final group = Provider.of<Group>(context, listen: false);


    Map<String, dynamic> args = {"item":item, "group":group};

    
    return GestureDetector(
      child: itemMedia == "video"
          ? ListTile(
              leading: Icon(Icons.play_circle_outline),
              title:
                  Text(itemTitle, style: Theme.of(context).textTheme.headline5),
            )
          : ListTile(
              title:
                  Text(itemTitle, style: Theme.of(context).textTheme.headline5),
            ),
      onTap: () => Navigator.of(context).pushNamed(
        DetailedRepoItemScreen.routeName,
        arguments: item
        // arguments: args,
      ),
    );
  }
}
