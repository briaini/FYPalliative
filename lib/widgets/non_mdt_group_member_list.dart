import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';

class NonMdtGroupMemberList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    final users = group.members;

    return users == null
        ? Center(
            child: Text('No Members'),
          )
        : Column(
            children: List<Widget>.generate(
                users.length,
                (i) =>
                    //   Card(
                    //     child: Text(users[i].name),
                    //   ),
                    // ).toList());

                    Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                CircleAvatar(
                                  maxRadius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/images/usertile16.bmp'),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      users[i].name,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      users[i].role,
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )).toList());
  }
}
