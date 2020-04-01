import 'package:flutter/material.dart';

import '../providers/item.dart';
import './comments_list.dart';

class TextItem extends StatelessWidget {
  final Item item;

  TextItem(this.item);

  @override
  Widget build(BuildContext context) {
    print("building text_item: ${item.id}");
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          item.image_url != null
              ? Container(
                  width: double.infinity,
                  height: 250,
                  child: Image.network(
                    item.image_url,
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
          CommentsList(item),
          // Expanded(
          //   child: CommentsList(),
          // ),
        ],
      ),
    );
  }
}
