import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';

enum GroupType { md, mdt, admin }

class EditGroupScreen extends StatefulWidget {
  static const routeName = '/edit-group-screen';

  @override
  _EditGroupScreenState createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  final _form = GlobalKey<FormState>();
  final _isMdtFocusNode = FocusNode();

  var _isInit = true;
  var _isLoading = false;
  var _isMdt = true;

  Map<String, dynamic> _initValues = {
    'name': '',
    'isMdt': null,
  };

  Map<String, dynamic> _editedGroup = {
    'id': null,
    'name': null,
    'isMdt': null,
  };

  // var _editedGroup = Group(
  //   id: null,
  //   title: '',
  // 'isMdt':null,
  // );
  @override
  void dispose() {
    _isMdtFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // Group group = ModalRoute.of(context).settings.arguments as Group;
      final groupId = ModalRoute.of(context).settings.arguments as int;
      if (groupId != null) {
        //user provider to obtain group by id. Load values into initvalues map
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    _editedGroup["isMdt"] = _isMdt;
    final isFormValid = _form.currentState.validate();
    if (!isFormValid) return;
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedGroup['id'] != null) {
      // try to update group
    } else {
      //add group
      try {
        await Provider.of<Patients>(context, listen: false)
            .addGroup(_editedGroup);
        await Provider.of<Patients>(context).fetchGroups().then(
              (_) => setState(
                () {
                  _isLoading = false;
                  Navigator.of(context).pop();
                },
              ),
            );
      } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error Occurred!'),
            content: Text('Something went wrong while creating post.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Group Screen",
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
            )
          ],
        ),
        body: Container(
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['name'],
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_isMdtFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedGroup['name'] = value;
                  },
                ),
                SwitchListTile(
                    title: Text('Does group have a patient?'),
                    onChanged: (boo) {
                      setState(() {
                        _isMdt = boo;
                        _editedGroup['isMdt'] = boo;
                      });
                    },
                    value: _isMdt),
                // TextFormField(
                //   focusNode: _isMdtFocusNode,
                //   initialValue: _initValues['isMdt'],
                //   decoration: InputDecoration(
                //     labelText: 'Is Mdt ("true" or "false")',
                //   ),
                //   textInputAction: TextInputAction.next,
                //   validator: (value) {
                //     // var validMedia = ['true', 'false'];
                //     // if (!validMedia.contains(value)) {
                //     //   // return 'Please enter "true" or "false"';
                //     // }
                //     // return null;
                //     if (value.isEmpty) {
                //       return 'Please enter a title';
                //     }
                //     return null;
                //   },
                //   onSaved: (value) {
                //     _editedGroup['isMdt'] = value;
                //   },
                //   onFieldSubmitted: (_) {
                //     _saveForm();
                //   },
                // ),
              ],
            ),
          ),
        ));
  }
}
