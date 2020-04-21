import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import './detailed_user_list_item.dart';


class DetailedUserList extends StatefulWidget {
  DetailedUserList();

  @override
  _DetailedUserListState createState() => _DetailedUserListState();
}

class _DetailedUserListState extends State<DetailedUserList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Patients>(
      builder: (ctx, patients, child) => Container(
        child: 
            ListView.separated(
                padding: EdgeInsets.all(8),
                itemCount: patients.groups.length,
                itemBuilder: (_, i) => ChangeNotifierProvider.value(
                  value: patients.groups[i],
                  child: DetailedUserListItem(),
                ),
                separatorBuilder: (_, i) => const Divider(),
              ),
      ),
    );
  }
}