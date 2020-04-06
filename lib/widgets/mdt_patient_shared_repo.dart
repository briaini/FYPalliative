import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patient.dart';
import '../providers/patients.dart';
import '../widgets/repository_list.dart';

class MdtPatientSharedRepo extends StatefulWidget {
  // final patientId;

  // MdtPatientRepo(this.patientId);

  @override
  _MdtPatientSharedRepoState createState() => _MdtPatientSharedRepoState();
}

class _MdtPatientSharedRepoState extends State<MdtPatientSharedRepo> {
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(
  //       () {
  //         _isLoading = true;
  //       },
  //     );
  //     Provider.of<Patient>(context).fetchComments().then(
  //       (_) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       },
  //     );
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<Patient>(context);

    return _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
              : Text(patient.posts.toString());
            // : RepositoryList();
  }
}
