import 'package:FlutterFYP/models/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patient.dart';
import '../providers/group.dart';
import '../providers/auth.dart';
import '../providers/patients.dart';
import './share_patient_list_item.dart';

class SharePatientsList extends StatefulWidget {
  @override
  _SharePatientsListState createState() => _SharePatientsListState();
}

class _SharePatientsListState extends State<SharePatientsList> {
  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<Auth>(context).isAdmin;
    final arr = isAdmin
        ? Provider.of<Patients>(context).groups as List<Group>
        : Provider.of<Patients>(context).patients as List<UserDAO>;

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: arr.length,
      itemBuilder: isAdmin
          ? (_, i) => ChangeNotifierProvider.value(
                value: arr[i] as Group,
                child: SharePatientListItem(),
              )
          : (_, i) => ChangeNotifierProvider.value(
                value: arr[i] as UserDAO,
                child: SharePatientListItem(),
              ),
      separatorBuilder: (_, i) => const Divider(),
    );
  }
}
