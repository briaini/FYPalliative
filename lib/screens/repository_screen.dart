import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/repository.dart';
import '../widgets/repository_list.dart';

class RepositoryScreen extends StatefulWidget {
  @override
  _RepositoryScreenState createState() => _RepositoryScreenState();
}

class _RepositoryScreenState extends State<RepositoryScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(
        () {
          _isLoading = true;
        },
      );
      Provider.of<Repository>(context).fetchItems().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final repo = Provider.of<Repository>(context);
    // final items = repo.items;
    // rsepo.items;

    // print("reposcreen" + items.toString());
    // repoItems = repo.items;

    // print('reposcreen' + repo.items.toString());

    return _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RepositoryList();
  }
}
