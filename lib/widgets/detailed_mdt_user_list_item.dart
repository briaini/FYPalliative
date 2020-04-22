import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_dao.dart';
import '../screens/mdt_patient_screen.dart';

class DetailedMdtUserListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mdtWorker = Provider.of<UserDAO>(context);

    return GestureDetector(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(mdtWorker.name),
        ),
        onTap: () => (print('need to list mdt groups'))
        // Navigator.of(context)
        //         .pushNamed(MdtPatientScreen.routeName, arguments: group)

        );
  }
}
