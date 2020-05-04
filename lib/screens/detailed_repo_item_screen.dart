import 'package:FlutterFYP/providers/patients.dart';
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
    var groupId;

    var adminGroupId;
    //  && Provider.of<Auth>(context).isPatient

    final itemId = args['itemId'] as int;
    // final item = Provider.of<Repository>(context).findById(itemId);
    if (args.containsKey("adminGroupId"))
      adminGroupId = args['adminGroupId'] as int;
    if (Provider.of<Auth>(context).isPatient) {
      group = Provider.of<Repository>(context).group;
    } else if (args.containsKey("groupId")) {
      groupId = args['groupId'] as int;
      group = Provider.of<Patients>(context).findGroupById(groupId);
    }

    return group == null
        ?

        // return Provider.of<Auth>(context).isPatient
        //     ?
        // MultiProvider(
        //     providers: [
        //       ChangeNotifierProvider.value(
        //         value: group,
        //       ),
        //       // ChangeNotifierProvider.value(
        //       //   value: itemId,
        //       // ),
        //     ],
        // child:
        DetailedRepoItemScreenWithProv(itemId, false)
        // )
        // : group == null
        //     ?
        // ChangeNotifierProvider.value(
        //   value: itemId,
        //   child:
        // adminGroupId == null
        // ?
        // DetailedRepoItemScreenWithProv(group.id, itemId, false)
        :
        // DetailedRepoItemScreenWithProv(
        //     group.id, itemId, true, adminGroupId)
        // )

        // : MultiProvider(
        //     providers: [
        //       ChangeNotifierProvider.value(
        //         value: group,
        //       ),
        //       // ChangeNotifierProvider.value(
        //       //   value: itemId,
        //       // ),
        //     ],
        // child:
        DetailedRepoItemScreenWithProv(
            itemId,
            true,
            group.id,
          );
    //  ,
    // );

    // return ChangeNotifierProvider.value(
    //   value: item,
    //   child: DetailedRepoItemScreenWithProv(),
    // );
  }
}

class DetailedRepoItemScreenWithProv extends StatelessWidget {
  final hasComments;
  var groupId;
  final itemId;

  DetailedRepoItemScreenWithProv(
    this.itemId,
    this.hasComments, [
    this.groupId,
  ]);
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Repository>(context).findById(itemId);
    Group group;
    if (Provider.of<Auth>(context).isPatient) {
      group = Provider.of<Repository>(context).group;
    } else if (groupId != null) {
      group = Provider.of<Patients>(context).findGroupById(groupId);
    }

    return Scaffold(
      body: 
      item.media == 'video'
          ? (groupId == null
              ? ChangeNotifierProvider.value(
                  value: group, child: VideoScreen(item, hasComments))
              : ChangeNotifierProvider.value(
                  value: group, child: VideoScreen(item, hasComments, groupId)))
          : (groupId == null
              ? TextItemTabScreen(item, hasComments)
              : ChangeNotifierProvider.value(
                  value: group,
                  child: TextItemTabScreen(item, hasComments, groupId))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: hasComments
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (bCtx) {
                  return NewCommentModal(group.id, item.id);
                },
              ),
              backgroundColor: Theme.of(context).accentColor.withAlpha(225),
            )
          : null,
    );
  }
}
