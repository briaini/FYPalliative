import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/repository.dart';
import '../providers/item.dart';
import '../providers/group.dart';
import './comment_item.dart';

class CommentsList extends StatefulWidget {
  @override
  _CommentsListState createState() => _CommentsListState();
  final _itemId;

  CommentsList(this._itemId);
}

class _CommentsListState extends State<CommentsList> {
  var _isInit = true;
  var _isLoading = false;

  void saveComment(comment) {
    // Provider.of<Repository>(context).saveComment(comment);
  }

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    // final item = Provider.of<Item>(context);

    final comments =
        group.comments.where((comment) => comment.postId == widget._itemId).toList() ??
            [];

    return (comments.length < 1)
        ? Center(
            child: Text('No Comments'),
          )
        : Column(
            children: <Widget>[
              ExpansionTile(
                leading: Icon(Icons.comment),
                title: Text('Comments (${comments.length})'),
                children: <Widget>[
                  Container(
                    height: 225,
                      child: ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (_, i) => CommentItem(comments[i])),
                  ),
                ],

                // List<Widget>.generate(
                //   comments.length,
                //   (i) {
                //     return Column(
                //       children: <Widget>[
                //         CommentItem(comments[i]),
                //         if (i != comments.length - 1)
                //           Divider(
                //             height: 8,
                //           ),
                //       ],
                //     );
                //   },
                // ),
              ),
            ],
          );
  }
}
