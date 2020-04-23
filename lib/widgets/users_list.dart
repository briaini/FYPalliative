import 'package:FlutterFYP/models/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import './patients_list_item.dart';
import './user_list_item.dart';

class UsersList extends StatefulWidget {
  final args;
  final isMdtWorker;
  UsersList(this.args, this.isMdtWorker);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  _buildListView(List<UserDAO> arr) {
    if (arr.isEmpty)
      return Align(
        alignment: Alignment.topCenter,
        child: Text('No Results'),
      );
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: arr.length,
      itemBuilder: (_, i) => ChangeNotifierProvider.value(
        value: arr[i],
        child: UserListItem(widget.args),
      ),
      separatorBuilder: (_, i) => const Divider(),
    );
  }

  /**
   * checks value passed in constructor determining if mdtworker or patient user
   * builds list with all mdt workers or with available unassigned patient users
   */
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Patients>(context);
    // final mdtArr =  widget.isMdtWorker ? Provider.of<Patients>(context).mdtworkers : Provider.of<Patients>(context).unassignedPatientUsers;
    // final patientsArr = Provider.of<Patients>(context).unassignedPatientUsers;
    return widget.isMdtWorker
        ? _buildListView(prov.mdtworkers)
        : _buildListView(prov.unassignedPatientUsers);
    //         //isPatientUser
    //         patients.unassignedPatientUsers.isEmpty
    //             ? Align(
    //                 alignment: Alignment.topCenter,
    //                 child: Container(
    //                   padding: EdgeInsets.all(50),
    //                   child: Text('No unassigned patients'),
    //                 ),
    //               )
    //             : ListView.separated(
    //                 padding: EdgeInsets.all(8),
    //                 itemCount: patients.unassignedPatientUsers.length,
    //                 itemBuilder: (_, i) => ChangeNotifierProvider.value(
    //                   value: patients.unassignedPatientUsers[i],
    //                   child: UserListItem(widget.args),
    //                 ),
    //                 separatorBuilder: (_, i) => const Divider(),
    //               ),
    //   ),
    // );
  }
}
