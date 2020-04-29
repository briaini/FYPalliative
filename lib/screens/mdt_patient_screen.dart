import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
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
    final groupId = ModalRoute.of(context).settings.arguments as int;

    final group = Provider.of<Patients>(context).findGroupById(groupId);
   
    //BIG BUG FIXED: was passing group into mdtpatientscreen. Wasn't fetching updated group as this method wouldn't rebuild. group wouldn't update
    return ChangeNotifierProvider.value(
      value: group,
      child: InfoWidget(),
    );
  }
}

class InfoWidget extends StatefulWidget {
  static const routeName = '/info-widget';
  // var _showHidden = false;

  @override
  _InfoWidgetState createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  var _isInit = true;
  var _isLoading = false;
  var _hiddenFilter = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Patients>(context).fetchPatients();
      if (Provider.of<Auth>(context).isAdmin) {
        Provider.of<Patients>(context).fetchGroups().then(
          (_) {
            setState(() {
              _isLoading = false;
            });
          },
        );
      } else {
        Provider.of<Patients>(context).fetchMyGroups().then(
          (_) {
            setState(() {
              _isLoading = false;
            });
          },
        );
      }
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('building heyar');
    // final group = Provider.of<Group>(context);
    final patients = Provider.of<Patients>(context);
    final groupId = ModalRoute.of(context).settings.arguments as int;
    final group = patients.findGroupById(groupId);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              PopupMenuButton(
                onSelected: (PopupOptions selectedValue) {
                  setState(() {
                    if (selectedValue == PopupOptions.HiddenPosts) {
                      _hiddenFilter = !_hiddenFilter;
                    } else if (selectedValue == PopupOptions.RecommendPosts) {
                      Navigator.of(context).pushNamed(
                          MdtAllPostsAddScreen.routeName,
                          arguments: {"group": group});
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
                    child: Text(_hiddenFilter
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
          body: _isLoading
              ? CircularProgressIndicator()
              : TabBarView(
                  children: <Widget>[
                    MdtOverview(),
                    MdtPatientSharedRepo(_hiddenFilter),
                  ],
                )),
    );
  }
}
