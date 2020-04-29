import 'package:FlutterFYP/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../providers/repository.dart';
import '../widgets/admin_share_post_list.dart';

class AdminSharePostScreen extends StatefulWidget {
  static const routeName = '/admin-share-post-screen';

  @override
  _AdminSharePostScreenState createState() => _AdminSharePostScreenState();
}

class _AdminSharePostScreenState extends State<AdminSharePostScreen> {
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
      Provider.of<Repository>(context).fetchItems();

      Provider.of<Patients>(context).fetchGroups().then(
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
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final groupId = args['groupId'];

    final group = Provider.of<Patients>(context).findGroupById(groupId);

    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: 
      _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ChangeNotifierProvider.value(
              value: group,
              child: AdminSharePostList(),
            ),
    );
  }
}
