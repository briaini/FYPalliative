import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import './share_patient_list_item.dart';

class SharePatientsList extends StatefulWidget {
  @override
  _SharePatientsListState createState() => _SharePatientsListState();
}

class _SharePatientsListState extends State<SharePatientsList> {

  @override
  Widget build(BuildContext context) {
    return Consumer<Patients>(
      builder: (ctx, patients, child) => Container(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: patients.patients.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
            value: patients.patients[i],
            child: SharePatientListItem(),
          ),
          separatorBuilder: (_, i) => const Divider(),
        ),
      ),
    );
  }
}
