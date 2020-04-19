import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/repository.dart';
import '../widgets/admin_repository_list.dart';

class AdminAllPostsScreen extends StatefulWidget {
  static const routeName = '/admin-all-posts-screen.dart';
  @override
  _AdminAllPostsScreenState createState() => _AdminAllPostsScreenState();
}

class _AdminAllPostsScreenState extends State<AdminAllPostsScreen> {
  var _isLoading = false;
  var _isInit = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(
        () {
          _isLoading = true;
        },
      );
      Provider.of<Repository>(context).fetchItems().then(
            (_) => setState(
              () {
                _isLoading = false;
              },
            ),
          );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final groupId = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : AdminRepositoryList(groupId),
    );
  }
}
