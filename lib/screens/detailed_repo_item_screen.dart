import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/item.dart';
import '../providers/group.dart';
import '../providers/repository.dart';
import '../screens/text_item_tab_screen.dart';
import '../screens/video_screen.dart';
import '../widgets/new_comment_modal.dart';

class DetailedRepoItemScreen extends StatelessWidget {
  static const routeName = '/detailed-repo-item-screen';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    Group group;
    if (args.containsKey("group")) group = args['group'] as Group;
    final item = args['item'] as Item;

    return group == null
        ? ChangeNotifierProvider.value(
            value: item,
            child: DetailedRepoItemScreenWithProv(false),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: group,
              ),
              ChangeNotifierProvider.value(
                value: item,
              ),
            ],
            child: DetailedRepoItemScreenWithProv(true),
          );

    // return ChangeNotifierProvider.value(
    //   value: item,
    //   child: DetailedRepoItemScreenWithProv(),
    // );
  }
}

class DetailedRepoItemScreenWithProv extends StatelessWidget {
  final hasComments;

  DetailedRepoItemScreenWithProv(this.hasComments);
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);

    return Scaffold(
      body: item.media == 'video'
          ? VideoScreen(hasComments)
          : TextItemTabScreen(hasComments),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: hasComments
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (bCtx) {
                  return NewCommentModal(Provider.of<Group>(context, listen: false).id, item.id);
                },
              ),

              // Provider.of<Repository>(context).createComment(context, item),

              backgroundColor: Colors.purple,
            )
          : null,
    );
  }
}
