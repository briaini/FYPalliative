import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import './comments_list.dart';

class TextItem extends StatelessWidget {
  final hasComments;
  
  TextItem(this.hasComments);

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);

    print("building text_item: ${item.id}");
    print("image URL: $item");
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          item.imageUrl != null
              ? Container(
                  width: double.infinity,
                  height: 250,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          Text(item.title),
          SizedBox(
            height: 10,
          ),
          Text(item.description),
          SizedBox(
            height: 10,
          ),
          hasComments ? CommentsList() : Container(),
          // Expanded(
          //   child: CommentsList(),
          // ),
        ],
      ),
    );
  }
}
