import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/messages_list.dart';
import '../widgets/new_message_modal.dart';
import '../widgets/non_mdt_group_member_list.dart';

class NonMdtGroupOverviewScreen extends StatelessWidget {
  static const routeName = '/non-mdt-group-overview-screen';
  @override
  Widget build(BuildContext context) {
    final _groupId = ModalRoute.of(context).settings.arguments as int;
    final _group = Provider.of<Patients>(context).findNonMdtGroupById(_groupId);
    // findGroupById(_groupId);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_group.name),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.comment),
              ),
              Tab(
                icon: Icon(Icons.contacts),
              ),
            ],
          ),
        ),
        body: ChangeNotifierProvider.value(
          value: _group,
          child: TabBarView(children: <Widget>[
            MessagesList(),
            NonMdtGroupMemberList(),
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (bCtx) {
              return NewMessageModal(_group.id);
            },
          ),
          backgroundColor: Theme.of(context).accentColor.withAlpha(225),
        ),
      ),
    );
  }
}
