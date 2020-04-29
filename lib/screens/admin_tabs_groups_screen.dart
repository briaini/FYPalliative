import 'package:FlutterFYP/models/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/groups_list.dart';
import './edit_group_screen.dart';

class AdminTabsGroupsScreen extends StatefulWidget {
  static const routeName = "/admin-tabs-groups-screen";

  @override
  _AdminTabsGroupsScreenState createState() => _AdminTabsGroupsScreenState();
}

class _AdminTabsGroupsScreenState extends State<AdminTabsGroupsScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Patients>(context).fetchGroups().then(
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

  @override
  Widget build(BuildContext context) {
    // final optionalMdtWorker =
    //     ModalRoute.of(context).settings.arguments as UserDAO;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        // : optionalMdtWorker == null
            // ?
            : GroupsList();
            // : GroupsList(optionalMdtWorker);
  }
}
