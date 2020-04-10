import 'package:FlutterFYP/providers/comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/repository.dart';

class NewCommentModal extends StatefulWidget {
  @override
  _NewCommentModalState createState() => _NewCommentModalState();
  final item;
  NewCommentModal(this.item);
}

class _NewCommentModalState extends State<NewCommentModal> {
  final _commentController = TextEditingController();
  
  void _submitComment(){
    final commentText = _commentController.text;
    if(commentText.isEmpty)
      return;
    // final comment = new Comment(postId: widget.item.getId, textBody: commentText);
    // Provider.of<Repository>(context,listen: false).saveComment(comment);
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Comment'),
                controller: _commentController,
                onSubmitted: (_) => _submitComment(),
              ),
              RaisedButton(
                child: Text('Add Comment'),
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).buttonColor,
                onPressed: _submitComment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
