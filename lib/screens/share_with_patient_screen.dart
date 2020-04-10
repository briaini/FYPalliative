import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../providers/patients.dart';
import '../widgets/share_patient_list.dart';

class ShareWithPatientScreen extends StatefulWidget {
  static const routeName = '/share-with-patient-screen';

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
    final item = ModalRoute.of(context).settings.arguments as Item;
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
      ),
      body: _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ChangeNotifierProvider.value(
            value: item,
            child: SharePatientsList(),
          )
    );
  }
}
