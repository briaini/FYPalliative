import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/item.dart';
import '../providers/repository.dart';
import '../screens/text_item_tab_screen.dart';
import '../screens/video_screen.dart';

class DetailedRepoItemScreen extends StatelessWidget {
  static const routeName = '/detailed-repo-item-screen';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context).settings.arguments as Item;
    // print("inDetailedRepoItemS: ${ModalRoute.of(context).settings.arguments.toString()}");
    // print("inDetailedRepoItemScreen: ${item.id}");

    return Scaffold(
      body: item.media == 'video' ? VideoScreen(item) : TextItemTabScreen(item),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Provider.of<Repository>(context).createComment(context, item),
        // _createComment(context),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
