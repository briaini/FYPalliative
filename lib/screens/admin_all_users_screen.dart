import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/users_list.dart';

class AdminAllUsersScreen extends StatefulWidget {
  static const routeName = '/admin-all-users-screen';
  @override
  _AdminAllUsersScreenState createState() => _AdminAllUsersScreenState();
}

class _AdminAllUsersScreenState extends State<AdminAllUsersScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
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
    final groupId = ModalRoute.of(context).settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : UsersList(),
    );
  }
}
