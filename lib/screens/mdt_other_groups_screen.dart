import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/mdt_other_groups_list_item.dart';

class MdtOtherGroupsScreen extends StatefulWidget {
  static const routeName = '/mdt-other-groups-screen';
  @override
  _MdtOtherGroupsScreenState createState() => _MdtOtherGroupsScreenState();
}

class _MdtOtherGroupsScreenState extends State<MdtOtherGroupsScreen> {
  var _isLoading = false;
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(
        () {
          _isLoading = true;
        },
      );
      Provider.of<Patients>(context).fetchMyGroups().then(
            (_) => setState(
              () {
                _isLoading = false;
              },
            ),
          );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final patientsProv = Provider.of<Patients>(context);
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(title: Text("Non-Mdt Groups"),),
            body: ListView.builder(
              itemCount: patientsProv.nonMdtGroups.length,
              itemBuilder: (_, i) => MdtOtherGroupsListItem(patientsProv.nonMdtGroups[i]),
            ),
          );
  }
}
