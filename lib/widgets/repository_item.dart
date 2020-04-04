import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../screens/detailed_repo_item_screen.dart';

class RepositoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Item>(context, listen: false);
    final itemMedia = itemProvider.media;
    final itemTitle = itemProvider.title;

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
        arguments: Item(
          id: itemProvider.id,
          media: itemMedia,
          category: itemProvider.category,
          title: itemTitle,
          description: itemProvider.description,
          linkUrl: itemProvider.linkUrl,
          imageUrl: itemProvider.imageUrl,
          comments: itemProvider.comments,
        ),
      ),
    );
  }
}
