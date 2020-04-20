import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';

class AdminDetailedOverviewMdtUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mdtUserProv = Provider.of<UserDAO>(context);
    // final isMDT = userProv.role == "MDT";/
    return Scaffold(
      appBar: AppBar(
          title: Text(mdtUserProv.role)
          ),
      body: Container(),);
  }
}