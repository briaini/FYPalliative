import 'package:FlutterFYP/widgets/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:FlutterFYP/providers/patients.dart';

class ShareWithPatientScreen extends StatefulWidget {
  static const routename = '/share-with-patient-screen';

  @override
  _ShareWithPatientScreenState createState() => _ShareWithPatientScreenState();
}

class _ShareWithPatientScreenState extends State<ShareWithPatientScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(
        () {
          _isLoading = true;
        },
      );
      Provider.of<Patients>(context).fetchPatients().then(
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
      ),
      body: _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : PatientsList(),
    );
  }
}
