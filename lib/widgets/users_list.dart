import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import './patients_list_item.dart';
import './user_list_item.dart';


class UsersList extends StatefulWidget {
  final args;
  UsersList(this.args);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Patients>(
      builder: (ctx, patients, child) => Container(
        child: ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount: patients.users.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
            value:  patients.users[i],
            child: 
              UserListItem(widget.args),
          ),
          separatorBuilder: (_, i) => const Divider(),
        ),
      ),
    );
  }
}
