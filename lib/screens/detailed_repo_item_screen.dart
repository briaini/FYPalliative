import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../providers/group.dart';
import '../providers/repository.dart';
import '../screens/text_item_tab_screen.dart';
import '../screens/video_screen.dart';

class DetailedRepoItemScreen extends StatelessWidget {
  static const routeName = '/detailed-repo-item-screen';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final group = args['group'] as Group;
    final item = args['item'] as Item;

    // final group = args['group'] as Group;
    // final item = ModalRoute.of(context).settings.arguments as Item;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: group,
        ),
        ChangeNotifierProvider.value(
          value: item,
        ),
      ],
      child: DetailedRepoItemScreenWithProv(),
    );

    // return ChangeNotifierProvider.value(
    //   value: item,
    //   child: DetailedRepoItemScreenWithProv(),
    // );
  }
}

class DetailedRepoItemScreenWithProv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);

    return Scaffold(
      body: item.media == 'video' ? VideoScreen() : TextItemTabScreen(item),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Provider.of<Repository>(context).createComment(context, item),
        // _createComment(context),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
