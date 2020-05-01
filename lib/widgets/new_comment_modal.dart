import 'package:FlutterFYP/providers/patients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/repository.dart';

class NewCommentModal extends StatefulWidget {
  @override
  _NewCommentModalState createState() => _NewCommentModalState();
  final itemId;
  final groupId;

  NewCommentModal(this.groupId, this.itemId);
}

class _NewCommentModalState extends State<NewCommentModal> {
  final _commentController = TextEditingController();

  Future<void> _submitComment(groupId, itemId) async {
    final commentText = _commentController.text;
    if (commentText.isEmpty) return;
    // final comment = new Comment();
    try {
      await Provider.of<Repository>(context)
          .saveComment(groupId, itemId, commentText);
      if (Provider.of<Auth>(context).isAdmin) {
        Provider.of<Patients>(context).fetchGroups();
      } else {
        await Provider.of<Repository>(context).fetchGroup().then(
              (_) => setState(
                () {
                  Navigator.of(context).pop();
                },
              ),
            );
      }
    } catch (e) {}
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
                onSubmitted: (_) =>
                    _submitComment(widget.groupId, widget.itemId),
              ),
              RaisedButton(
                  child: Text('Add Comment'),
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).buttonColor,
                  onPressed: () {
                    // Navigator.of(context).pop(true);

                    _submitComment(widget.groupId, widget.itemId);
                  }

                  // ()

                  // => _submitComment(widget.groupId, widget.itemId),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
