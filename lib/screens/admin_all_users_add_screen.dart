import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/users_list.dart';

class AdminAllUsersAddScreen extends StatefulWidget {
  static const routeName = '/admin-all-users-screen';
  @override
  _AdminAllUsersAddScreenState createState() => _AdminAllUsersAddScreenState();
}

class _AdminAllUsersAddScreenState extends State<AdminAllUsersAddScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Patients>(context).fetchGroups();
      Provider.of<Patients>(context).fetchUsers().then(
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
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Medical',
                icon: Icon(Icons.local_hospital),
              ),
              Tab(
                text: 'Patient',
                icon: Icon(Icons.healing),
              ),
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            :
            // : UsersList(args),
            TabBarView(
                children: <Widget>[
                  UsersList(
                    args, true,

                    // "mdt",
                  ),
                  UsersList(
                    args, false,
                    // "patients",
                  ),
                ],
              ),
      ),
    );
  }
}
