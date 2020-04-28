import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import './detailed_user_list_item.dart';
import '../screens/no_group_user_screen.dart';

class DetailedUserList extends StatefulWidget {
  DetailedUserList();

  @override
  _DetailedUserListState createState() => _DetailedUserListState();
}

class _DetailedUserListState extends State<DetailedUserList> {
  @override
  Widget build(BuildContext context) {
    final patientsProvider = Provider.of<Patients>(context);

//changing to show all patients
    return Column(
      children: List<Widget>.generate(
        patientsProvider.mdtGroupsWithPatient.length,
        (i) => ChangeNotifierProvider.value(
          value: patientsProvider.mdtGroupsWithPatient[i],
          child: DetailedUserListItem(),
        ),
      )..addAll(
          List<Widget>.generate(
            patientsProvider.newUnassignedPatientUsers.length,
            (i) => ChangeNotifierProvider.value(
              value: patientsProvider.newUnassignedPatientUsers[i],
              child: GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text(
                        patientsProvider.newUnassignedPatientUsers[i].name),
                  ),
                  onTap: () => Navigator.of(context)
                      .pushNamed(NoGroupUserScreen.routeName)

                  // Navigator.of(context).pushNamed(
                  //   MdtPatientScreen.routeName,
                  // arguments: group,
                  // ),
                  ),
            ),
          ),
        ),
    );

    // return Container(
    //   child: ListView.separated(
    //     padding: EdgeInsets.all(8),
    //     itemCount: patientsProvider.allPatients.length,
    //     itemBuilder: (_, i) => ChangeNotifierProvider.value(
    //       value: patientsProvider.allPatients[i],
    //       child: DetailedUserListItem(),
    //     ),
    //     separatorBuilder: (_, i) => const Divider(),
    //   ),
    // );
  }
}
