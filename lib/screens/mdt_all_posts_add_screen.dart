import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/group.dart';
import '../providers/repository.dart';
import '../providers/patients.dart';
import '../widgets/admin_repository_list.dart';

//admin add post to group
class MdtAllPostsAddScreen extends StatefulWidget {
  static const routeName = '/mdt-all-posts-add-screen.dart';
  @override
  _MdtAllPostsAddScreenState createState() => _MdtAllPostsAddScreenState();
}

class _MdtAllPostsAddScreenState extends State<MdtAllPostsAddScreen> {
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
      Provider.of<Patients>(context).fetchMyGroups();
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
    final args = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    final group = args['group'] as Group;

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: 
      _isLoading
          ? 
          Center(
              child: CircularProgressIndicator(),
            )
          : AdminRepositoryList(group.id),
    );
  }
}
