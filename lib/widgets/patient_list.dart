import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import './share_patient_list_item.dart';

class PatientsList extends StatefulWidget {
  final postId;

  PatientsList(this.postId);

  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Repository>(context).fetchItems().then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<Patients>(
      builder: (ctx, patients, child) => Container(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: patients.patients.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
            value: patients.patients[i],
            child: SharePatientListItem(patients.patients[i], widget.postId),
          ),
          separatorBuilder: (_, i) => const Divider(),
        ),
      ),
    );
  }
}
