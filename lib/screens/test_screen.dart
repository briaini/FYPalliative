import 'package:FlutterFYP/providers/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/repository.dart';


class TestScreen extends StatelessWidget {

  static const routeName = "/test-screen";
  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<Auth>(context, listen: false);
    // final repo = Provider.of<Repository>(context,listen: false);
    // repo.fetchItems();
    // auth.authenticate("brian", "password");

    return Scaffold(
      body: Center(
        child: Text("hello"),
      ),
    );
  }
}


// import 'package:FlutterFYP/widgets/my_tab_indicator.dart';
// import 'package:flutter/material.dart';

// import './test_screen.dart';

// class AdminUserOverviewScreen extends StatefulWidget {
//   static const routeName = '/admin-user-overview-screen';

//   @override
//   _AdminUserOverviewScreenState createState() =>
//       _AdminUserOverviewScreenState();
// }

// class _AdminUserOverviewScreenState extends State<AdminUserOverviewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('User Overview'),
//           bottom: TabBar(
//             labelStyle: TextStyle(fontWeight: FontWeight.bold),
//             labelColor: Colors.white,
//             indicatorSize: TabBarIndicatorSize.tab,
//             tabs: <Widget>[
//               Tab(text: "Tab1"),
//               Tab(text: "Tab2"),
//             ],
//             isScrollable: true,
//             indicator: BoxDecoration(
//                 color: Colors.black, borderRadius: BorderRadius.circular(50)),
//           ),
//         ),
//         body: TabBarView(
//           children: <Widget>[
//             TestScreen(),
//             TestScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }
