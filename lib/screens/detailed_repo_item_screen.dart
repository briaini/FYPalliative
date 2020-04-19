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
    var adminGroupId;
    if (args.containsKey("group")) group = args['group'] as Group;
    final item = args['item'] as Item;
    if(args.containsKey("submarine")) adminGroupId = args['submarine'] as int;
    print('test in detailedrepotitemScreen: $adminGroupId');

    if(!Provider.of<Auth>(context).isMDT){
      group = Provider.of<Repository>(context).group;
    }

    return group == null
        ? ChangeNotifierProvider.value(
            value: item,
            child: DetailedRepoItemScreenWithProv(false, adminGroupId),
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
  var groupId;

  DetailedRepoItemScreenWithProv(this.hasComments, [this.groupId]);
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);

    return Scaffold(
      body: item.media == 'video'
          ? (groupId == null ? VideoScreen(hasComments) : VideoScreen(hasComments, groupId))
          : (groupId == null ? TextItemTabScreen(hasComments): TextItemTabScreen(hasComments, groupId)),
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
              backgroundColor: Theme.of(context).accentColor.withAlpha(225),
            )
          : null,
    );
  }
}
