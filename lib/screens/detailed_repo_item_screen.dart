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
    //from RepositoryItem (RepositoryList or AdminRepositoryList)
    // {"item": item, "group": Provider.of<Repository>(context).group} or
    // : {"item": item, "adminGroupId": adminGroupId}; or
    //{"item: item"}
    //from DetailedRepositoryItem
    //{"item": item, "group": group};
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    Group group;
    var adminGroupId;
    if (args.containsKey("group")) group = args['group'] as Group;
    final itemId = args['itemId'] as int;
    final item = Provider.of<Repository>(context).findById(itemId);
    if (args.containsKey("adminGroupId"))
      adminGroupId = args['adminGroupId'] as int;
    if (Provider.of<Auth>(context).isAdmin) {
      group = Provider.of<Repository>(context).group;
    }
    print('in detailedrepoitemscreen group is $group');

    return Provider.of<Auth>(context).isPatient
        ? MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: group,
              ),
              // ChangeNotifierProvider.value(
              //   value: itemId,
              // ),
            ],
            child: DetailedRepoItemScreenWithProv(item,true),
          )
        : group == null
            ? 
              // ChangeNotifierProvider.value(
              //   value: itemId,
              //   child: 
                adminGroupId == null
                    ? DetailedRepoItemScreenWithProv(item, false)
                    : DetailedRepoItemScreenWithProv(item, true, adminGroupId)
              // )
              
            : MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(
                    value: group,
                  ),
                  // ChangeNotifierProvider.value(
                  //   value: itemId,
                  // ),
                ],
                child: DetailedRepoItemScreenWithProv(item, true),
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
  final item;

  DetailedRepoItemScreenWithProv(this.item, this.hasComments, [this.groupId]);
  @override
  Widget build(BuildContext context) {

    // final item1 = Provider.of<Repository>(context).findById(itemId);
    final group = hasComments ? Provider.of<Group>(context) : null;

    return Scaffold(
      body: item.media == 'video'
          ? (groupId == null
              ? ChangeNotifierProvider.value(
                  value: group, child: VideoScreen(item, hasComments))
              : VideoScreen(item, hasComments, groupId))
          : (groupId == null
              ? TextItemTabScreen(item, hasComments, group)
              : TextItemTabScreen(item, hasComments, groupId)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: hasComments
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (bCtx) {
                  return NewCommentModal(
                      Provider.of<Group>(context, listen: false).id, item.id);
                },
              ),
              backgroundColor: Theme.of(context).accentColor.withAlpha(225),
            )
          : null,
    );
  }
}
