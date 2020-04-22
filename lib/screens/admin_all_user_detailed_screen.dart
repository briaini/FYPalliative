import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/detailed_user_list.dart';

class AdminAllUserDetailedScreen extends StatefulWidget {
  static const routeName = '/admin-all-user-detailed-screen';
  @override
  _AdminAllUserDetailedScreenState createState() =>
      _AdminAllUserDetailedScreenState();
}

class _AdminAllUserDetailedScreenState
    extends State<AdminAllUserDetailedScreen> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
            ? CircularProgressIndicator()
            : TabBarView(
                children: <Widget>[
                  DetailedUserList(),
                  DetailedUserList(),
                ],
              ),
      ),
    );
  }
}