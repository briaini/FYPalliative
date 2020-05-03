import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import './comments_list.dart';

class TextItem extends StatelessWidget {
  final _item;
  final _hasComments;

  TextItem(this._item, this._hasComments);

  @override
  Widget build(BuildContext context) {
    // final item = Provider.of<Item>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(),
          _item.imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  ),
                  child: Image.network(
                    _item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              // )
              : Container(),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  _item.title,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _item.description,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          _hasComments ? CommentsList(_item.id) : Container(),
          // Expanded(
          //   child: CommentsList(),
          // ),
        ],
      ),
    );
  }
}
