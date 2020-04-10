import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import './repository_item.dart';
import '../providers/repository.dart';

class RepositoryList extends StatefulWidget {
  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Repository>(context).fetchItems().then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

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
