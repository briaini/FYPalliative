import 'package:FlutterFYP/screens/share_with_patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './edit_repository_item_screen.dart';
import '../providers/auth.dart';
import '../providers/patients.dart';
import '../providers/item.dart';
import '../widgets/text_item_web_view.dart';
import '../widgets/text_item.dart';

class TextItemTabScreen extends StatefulWidget {
  final hasComments;
  var groupId;

  TextItemTabScreen(this.hasComments, [this.groupId]);

  @override
  _TextItemTabScreen createState() => _TextItemTabScreen();
}

class _TextItemTabScreen extends State<TextItemTabScreen> {
  void _goToShareWithPatientPage(item) {
    Navigator.of(context).pushNamed(
      ShareWithPatientScreen.routeName,
      arguments: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final item = Provider.of<Item>(context, listen: false);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: auth.isMDT || auth.isAdmin
              ? <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    onPressed: () => Navigator.of(context).pushNamed(
                      EditRepositoryItemScreen.routeName,
                      arguments: item.id,
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.share),
                      onPressed: widget.groupId == null
                          ? () => _goToShareWithPatientPage(item)
                          : () {
                              showDialog(
                                  //returning showDialog returns Future for us
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text('Are you sure?'),
                                        content: Text(
                                            'Do you want to share post(${item.id}) with group: :${widget.groupId}?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('No'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop(false);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Yes'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop(true);
                                              Provider.of<Patients>(context)
                                                  .linkPostToGroup(
                                                      widget.groupId, item.id);
                                            },
                                          ),
                                        ],
                                      ));
                            }),
                  widget.hasComments
                      ? IconButton(
                          icon: Icon(
                            Icons.visibility_off,
                            color: Theme.of(context).primaryIconTheme.color,
                          ),
                          onPressed: () =>
                              // setState(() {
                              Provider.of<Patients>(context)
                                  .mdtSwapGroupPostVisibility(
                                      item.id, widget.groupId)
                          // })
                          //  () => Provider.of<Patients>(context)
                          //     .mdtSwapGroupPostVisibility(item.id, widget.groupId)
                          )
                      : Container(),
                ]
              : <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.visibility_off,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    onPressed: () => Provider.of<Patients>(context)
                        .hidePostFromGroup(item.id),
                  ),
                ],
          title: Text(item.title),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.message),
              ),
              Tab(
                icon: Icon(Icons.link),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TextItem(widget.hasComments),
            TextItemWebView(),
          ],
        ),
      ),
    );
  }
}
