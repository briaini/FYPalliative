import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../providers/group.dart';
import '../widgets/mdt_patient_shared_repo.dart';
import '../widgets/mdt_overview.dart';
import './admin_all_users_add_screen.dart';
import './admin_share_post_screen.dart';
import './mdt_all_posts_add_screen.dart';

enum GroupOptions {
  User,
  Post,
}

class AdminGroupDetailScreen extends StatelessWidget {
  static const routeName = '/admin-group-detail-screen';

  @override
  Widget build(BuildContext context) {
    final groupId = ModalRoute.of(context).settings.arguments as int;
    final group = Provider.of<Patients>(context).findGroupById(groupId);
    return ChangeNotifierProvider.value(
      value: group,
      child: AdminGroupDetailScreenInfo(),
    );
  }
}

class AdminGroupDetailScreenInfo extends StatefulWidget {
  @override
  _AdminGroupDetailScreenInfoState createState() =>
      _AdminGroupDetailScreenInfoState();
}

class _AdminGroupDetailScreenInfoState
    extends State<AdminGroupDetailScreenInfo> {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (GroupOptions selectedValue) {
                setState(() {
                  if (selectedValue == GroupOptions.User) {
                    Navigator.of(context).pushNamed(
                        AdminAllUsersAddScreen.routeName,
                        arguments: {"groupId": group.id});
                    // Provider.of<Patients>(context, listen:false).linkUserToGroup(group.id, userId);
                  } else {
                    Navigator.of(context).pushNamed(
                        AdminSharePostScreen.routeName,
                        arguments: {"groupId": group.id});
                    // Navigator.of(context).pushNamed(AdminAllPostsScreen.routeName, arguments: group.id);
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Add Member'),
                  value: GroupOptions.User,
                ),
                PopupMenuItem(
                  child: Text('Add Post'),
                  value: GroupOptions.Post,
                ),
              ],
            ),
          ],
          title: Text(group.name),
          // title: Text('testers'),

          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.contacts),
              ),
              Tab(
                icon: Icon(Icons.description),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MdtOverview(),
            // MdtOverview(),

            MdtPatientSharedRepo(false),
          ],
        ),
      ),
    );
  }
}
