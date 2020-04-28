import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../providers/group.dart';
import '../widgets/mdt_patient_shared_repo.dart';
import '../widgets/mdt_overview.dart';
import './mdt_all_posts_add_screen.dart';

enum PopupOptions {
  HiddenPosts,
  RecommendPosts,
}

class MdtPatientScreen extends StatelessWidget {
  static const routeName = '/mdt-patient-screen';

  @override
  Widget build(BuildContext context) {
    // final patient = Provider.of<Patient>(context);
    final group = ModalRoute.of(context).settings.arguments as Group;

    return ChangeNotifierProvider.value(
      value: group,
      child: InfoWidget(),
    );
  }
}

class InfoWidget extends StatefulWidget {
  // var _showHidden = false;

  @override
  _InfoWidgetState createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    final patients = Provider.of<Patients>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (PopupOptions selectedValue) {
                setState(() {
                  if (selectedValue == PopupOptions.HiddenPosts) {
                    group.hiddenFilter = !group.hiddenFilter;
                  } else if (selectedValue == PopupOptions.RecommendPosts) {
                    Navigator.of(context).pushNamed(MdtAllPostsAddScreen.routeName, arguments: {"group":group});
                  }

                  // Navigator.of(context).pushNamed(
                  //     AdminAllUsersAddScreen.routeName,
                  //     arguments: {"groupId": group.id});
                  // Provider.of<Patients>(context, listen:false).linkUserToGroup(group.id, userId);
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(group.hiddenFilter
                      ? 'View Shared Items'
                      : 'View Hidden Items'),
                  value: PopupOptions.HiddenPosts,
                ),
                PopupMenuItem(
                  child: Text('Recommend Post'),
                  value: PopupOptions.RecommendPosts,
                ),
              ],
            ),
          ],
          title: Text(group.name),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.supervised_user_circle),
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
            MdtPatientSharedRepo(),
          ],
        ),
      ),
    );
  }
}
