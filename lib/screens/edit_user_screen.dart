import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserScreen extends StatefulWidget {
  static const routeName = '/edit-user-screen';
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;

  Map<String, dynamic> _initValues = {
    'username': '',
    'password': '',
    'role': '',
    'accountNonExpired': 1,
    'accountNonLocked': 1,
    'credentialsNonExpired': 1,
    'enabled': 1
  };

  Map<String, dynamic> _editedValues = {
    'id': '',
    'username': '',
    'password': '',
    'role': '',
    'accountNonExpired': 1,
    'accountNonLocked': 1,
    'credentialsNonExpired': 1,
    'enabled': 1
  };

  @override
  void dispose() {
    //dispose focusNodes, controllers...
    // .dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    //implement for editing, just doings adding atm

    // if (_isInit) {

    //   final groupId = ModalRoute.of(context).settings.arguments as int;
    //   if (groupId != null) {
    //     //user provider to obtain group by id. Load values into initvalues map
    //   }
    // }
    // _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if(_editedValues['id'] != null) {
      //implement update user
    } else {
      //add user

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Container(
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              // TextFormField(),

            ],
          ),
        ),
      ),
    );
  }
}
