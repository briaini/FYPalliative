import 'package:FlutterFYP/providers/patients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/repository.dart';

class NewMessageModal extends StatefulWidget {
  @override
  _NewMessageModalState createState() => _NewMessageModalState();

  final groupId;

  NewMessageModal(this.groupId);
}

class _NewMessageModalState extends State<NewMessageModal> {
  final _messageController = TextEditingController();

  Future<void> _submitMessage(groupId) async {
    final messageText = _messageController.text;
    if (messageText.isEmpty) return;
    // final comment = new Comment();
    try {
      await Provider.of<Patients>(context)
          .saveMessage(groupId, messageText, Provider.of<Auth>(context).username);
      if (Provider.of<Auth>(context).isAdmin) {
        Provider.of<Patients>(context).fetchGroups().then(
              (_) => setState(
                () {
                  Navigator.of(context).pop();
                },
              ),
            );
      } else if (Provider.of<Auth>(context).isMDT) {
        Provider.of<Patients>(context).fetchMyGroups().then(
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
                decoration: InputDecoration(labelText: 'Message'),
                controller: _messageController,
                onSubmitted: (_) =>
                    _submitMessage(widget.groupId),
              ),
              RaisedButton(
                  child: Text('Send Message'),
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).buttonColor,
                  onPressed: () {
                    // Navigator.of(context).pop(true);

                    _submitMessage(widget.groupId);
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
