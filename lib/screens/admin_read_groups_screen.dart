import 'package:FlutterFYP/models/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/groups_list.dart';
import './edit_group_screen.dart';

class AdminReadGroupsScreen extends StatefulWidget {
  static const routeName = "/mdt-patienet-shared-repo-screen";

  @override
  _AdminReadGroupsScreenState createState() => _AdminReadGroupsScreenState();
}

class _AdminReadGroupsScreenState extends State<AdminReadGroupsScreen> {
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
    return Scaffold(
        appBar: AppBar(
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.add),
          //     onPressed: () =>
          //         Navigator.of(context).pushNamed(EditGroupScreen.routeName),
          //   ),
          // ],
          title: Text('Groups'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            // : optionalMdtWorker == null
            // ?
            : GroupsList()
        // : GroupsList(optionalMdtWorker),
        );
  }
}
