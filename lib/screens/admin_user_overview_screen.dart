import 'package:FlutterFYP/models/user_dao.dart';
import 'package:FlutterFYP/widgets/my_tab_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/admin_detailed_overview_mdt_user.dart';
import '../widgets/admin_detailed_overview_patient_user.dart';


class AdminUserOverviewScreen extends StatefulWidget {
  static const routeName = '/admin-user-overview-screen';

  @override
  _AdminUserOverviewScreenState createState() =>
      _AdminUserOverviewScreenState();
}

class _AdminUserOverviewScreenState extends State<AdminUserOverviewScreen> {
  final categories = {
    'All': true,
    'Excercise': true,
    'Pain': true,
    'Stress': true
  };
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context).settings.arguments as UserDAO;
    final isMDT = user.role == "MDT";
    // return DefaultTabController(
    //   length: 2,
    //   child:
   return ChangeNotifierProvider.value(
        value: user,
        child: isMDT
            ? AdminDetailedOverviewMdtUser()
            : AdminDetailedOverviewPatientUser(),
    );
  }
}
