import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
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
      if (Provider.of<Auth>(context).isMDT || Provider.of<Auth>(context).isAdmin) {
        Provider.of<Repository>(context).fetchItems().then(
          (_) {
            setState(() {
              _isLoading = false;
            });
          },
        );
      // } else if (Provider.of<Auth>(context).isAdmin) {
      //   Provider.of<Repository>(context).fetchItems().then(
      //     (_) {
      //       setState(() {
      //         _isLoading = false;
      //       });
      //     },
      //   );
      } else {
        Provider.of<Repository>(context).fetchGroup().then(
          (_) {
            setState(() {
              _isLoading = false;
            });
          },
        );
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build reposiotry_screen');
    return _isLoading
        ?
        // Center(child: Text(Provider.of<Repository>(context).toString())
        CircularProgressIndicator()
        : RepositoryList();
  }
}
