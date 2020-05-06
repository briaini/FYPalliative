import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/patients.dart';
import '../widgets/patients_list.dart';

class PatientsScreen extends StatefulWidget {
  static const routeName = '/patients-screen';

  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      // Provider.of<Patients>(context).fetchPatients();
      if (Provider.of<Auth>(context).isAdmin) {
        Provider.of<Patients>(context).fetchGroups().then(
          (_) {
            setState(() {
              _isLoading = false;
            });
          },
        );
      } else {
        Provider.of<Patients>(context).fetchMyGroups().then(
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
  }

  @override
  Widget build(BuildContext context) {
      // final patients = Provider.of<Patients>(context);
      // final mdtGroups = patients.mdtGroupsWithPatient;
      // print(mdtGroups);
      // print('and here');
    
    return 
    // Scaffold(
    //   appBar: AppBar(
    //     title: Text('Patients'),
    //   ),
    //   body: 
      _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PatientsList();
    // );
  }
}
