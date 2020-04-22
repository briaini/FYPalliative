import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import './detailed_mdt_user_list_item.dart';


class DetailedMdtUserList extends StatefulWidget {
  @override
  _DetailedMdtUserListState createState() => _DetailedMdtUserListState();
}

class _DetailedMdtUserListState extends State<DetailedMdtUserList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Patients>(
      builder: (ctx, patients, child) => Container(
        child: 
            ListView.separated(
                padding: EdgeInsets.all(8),
                itemCount: patients.mdtworkers.length,
                itemBuilder: (_, i) => ChangeNotifierProvider.value(
                  value: patients.mdtworkers[i],
                  child: DetailedMdtUserListItem(),
                ),
                separatorBuilder: (_, i) => const Divider(),
              ),
      ),
    );
  }
}