import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import './patients_list_item.dart';
import './user_list_item.dart';

class UsersList extends StatefulWidget {
  final args;
  final isMDT;
  UsersList(this.args, this.isMDT);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Patients>(
      builder: (ctx, patients, child) => Container(
        child: widget.isMDT
            ? ListView.separated(
                padding: EdgeInsets.all(8),
                itemCount: patients.mdtworkers.length,
                itemBuilder: (_, i) => ChangeNotifierProvider.value(
                  value: patients.mdtworkers[i],
                  child: UserListItem(widget.args),
                ),
                separatorBuilder: (_, i) => const Divider(),
              )
            : patients.unassignedPatientUsers.isEmpty
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.all(50),
                      child: Text('No unassigned patients'),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(8),
                    itemCount: patients.unassignedPatientUsers.length,
                    itemBuilder: (_, i) => ChangeNotifierProvider.value(
                      value: patients.unassignedPatientUsers[i],
                      child: UserListItem(widget.args),
                    ),
                    separatorBuilder: (_, i) => const Divider(),
                  ),
      ),
    );
  }
}
