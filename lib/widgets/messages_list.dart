import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/repository.dart';
import '../providers/item.dart';
import '../providers/group.dart';
import './comment_item.dart';

class MessagesList extends StatefulWidget {
  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  var _isInit = true;
  var _isLoading = false;

  void saveComment(comment) {
    // Provider.of<Repository>(context).saveComment(comment);
  }

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);

    final messages =
        group.comments.where((comment) => comment.postId == null).toList() ??
            [];

    return (messages.length < 1)
        ? Center(
            child: Text('No Messages'),
          )
        : Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (_, i) => CommentItem(messages[i])),
          );

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
  }
}
