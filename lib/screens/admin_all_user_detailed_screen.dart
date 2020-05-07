import 'package:FlutterFYP/screens/edit_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widgets/detailed_user_list.dart';
import '../widgets/detailed_mdt_user_list.dart';

class AdminAllUserDetailedScreen extends StatefulWidget {
  static const routeName = '/admin-all-user-detailed-screen';
  @override
  _AdminAllUserDetailedScreenState createState() =>
      _AdminAllUserDetailedScreenState();
}

class _AdminAllUserDetailedScreenState
    extends State<AdminAllUserDetailedScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Patients>(context).fetchGroups();
      // Provider.of<Patients>(context).adminFetchUnassignedPatients();
      Provider.of<Patients>(context).fetchUsers().then(
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // appBar: AppBar(
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(Icons.add),
        //       onPressed: () =>
        //           Navigator.of(context).pushNamed(EditUserScreen.routeName),
        //     ),
        //   ],
        //   bottom: TabBar(
        //     tabs: <Widget>[
        //       Tab(
        //         text: 'Medical',
        //         icon: Icon(Icons.local_hospital),
        //       ),
        //       Tab(
        //         text: 'Patient',
        //         icon: Icon(Icons.healing),
        //       ),
        //     ],
        //   ),
        // ),
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new Container(
            height: 55.0,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              // labelColor: Theme.of(context).buttonColor,
              tabs: <Widget>[
                Tab(
                  text: 'Medical',
                  icon: Icon(Icons.local_hospital),
                ),
                Tab(
                  text: 'Patient',
                  icon: Icon(Icons.healing),
                ),
              ],
            ),
          ),
        ),

        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: <Widget>[
                  DetailedMdtUserList(), //Mdt will be list of PatientUsers
                  DetailedUserList(), //PatientUsers [Tabs: Mdt team & Recommended Posts]
                ],
              ),
      ),
    );
  }
}
