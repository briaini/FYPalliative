import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import './repository_item.dart';
import '../providers/repository.dart';

class AdminRepositoryList extends StatefulWidget {
  @override
  _AdminRepositoryListState createState() => _AdminRepositoryListState();
}

class _AdminRepositoryListState extends State<AdminRepositoryList> {
  var _isInit = true;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Repository>(
      builder: (ctx, repo, child) => Container(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: repo.items.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
              value: repo.items[i], 
              child: RepositoryItem()),
          separatorBuilder: (_, i) => const Divider(),
        ),
      ),
    );
  }
}
