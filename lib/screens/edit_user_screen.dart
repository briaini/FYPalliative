import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../providers/repository.dart';

enum Role { patient, mdt, admin }
enum AccountNonLocked { locked, unlocked }
enum AccountNonExpired { expired, nonexpired }
enum CredentialsNonExpired { expired, nonexpired }
enum AccountEnabled { disabled, enabled }

class EditUserScreen extends StatefulWidget {
  static const routeName = '/edit-user-screen';
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _form = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  var _isLoading = false;
  var _isInit = true;
  var _existingUser = false;

  Role _roleValue = Role.patient;
  AccountNonLocked _accountNonLockedValue = AccountNonLocked.unlocked;
  AccountNonExpired _accountNonExpiredValue = AccountNonExpired.nonexpired;
  CredentialsNonExpired _credentialsNonExpiredValue =
      CredentialsNonExpired.nonexpired;
  AccountEnabled _accountEnabledValue = AccountEnabled.enabled;

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
    'id': null,
    'username': '',
    'password': '',
    'role': 'PATIENT',
    'accountNonExpired': 1,
    'accountNonLocked': 1,
    'credentialsNonExpired': 1,
    'enabled': 1
  };

  @override
  void dispose() {
    //dispose focusNodes, controllers...
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    //implement for editing, just doings adding atm

    if (_isInit) {
      final existingUserMapString =
          ModalRoute.of(context).settings.arguments as String;
      _existingUser = existingUserMapString != null;

      final existingUserMap = json.decode(existingUserMapString);
      //     print(idkman['username']);

      if (_existingUser) {
        _initValues = existingUserMap;
        _editedValues['id'] = existingUserMap['id'];
        _roleValue = existingUserMap['role'] != 'MDT' ? Role.patient : Role.mdt;
        _accountNonLockedValue = existingUserMap['accountNonLocked']
            ? AccountNonLocked.unlocked
            : AccountNonLocked.locked;
        _accountNonExpiredValue = existingUserMap['accountNonExpired']
            ? AccountNonExpired.nonexpired
            : AccountNonExpired.expired;
        _credentialsNonExpiredValue = existingUserMap['credentialsNonExpired']
            ? CredentialsNonExpired.nonexpired
            : CredentialsNonExpired.expired;
        _accountEnabledValue = existingUserMap['enabled']
            ? AccountEnabled.enabled
            : AccountEnabled.disabled;
      }
    }
    print(_initValues);
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    if (!_form.currentState.validate()) return;
    setState(() {
      _isLoading = true;
    });
    _form.currentState.save();
    // setState(() {
    //   _isLoading = true;
    // });
    if (_existingUser) {
      try {
        await Provider.of<Repository>(context, listen: false)
            .updateUser(_editedValues);
        await Provider.of<Patients>(context)
            .fetchUsers()
            .then((value) => setState(() {
                  _isLoading = false;
                  Navigator.of(context).pop();
                }));
      } catch (e) {}
    } else {
      // print(_editedValues);
      //add user

      try {
        await Provider.of<Repository>(context, listen: false)
            .createUser(_editedValues);
        await Provider.of<Patients>(context).fetchUsers();
        await Provider.of<Patients>(context)
            .fetchGroups()
            .then((value) => setState(() {
                  _isLoading = false;
                  Navigator.of(context).pop();
                }));
      } catch (e) {
        // try {
        //   await Provider.of<Repository>(context, listen: false)
        //       .createUser(_editedValues);
        //   await Provider.of<Patients>(context)
        //       .adminFetchUnassignedPatients()
        //       .then(
        //         (value) => setState(
        //           () {
        //             _isLoading = false;
        //           },
        //         ),
        //       );
        // } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error Occurred!'),
            content: Text('Something went wrong while creating user.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Container(
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['username'],
                decoration: InputDecoration(labelText: 'Username'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  Focus.of(context).requestFocus(_passwordFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) return "Please enter value";
                  return null;
                },
                onSaved: (value) {
                  _editedValues['username'] = value;
                },
              ),
              _existingUser
                  ? Container()
                  : TextFormField(
                      focusNode: _passwordFocusNode,
                      initialValue: _initValues['password'],
                      decoration: InputDecoration(labelText: 'Password'),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        Focus.of(context).requestFocus();
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Please enter value";
                        return null;
                      },
                      onSaved: (value) {
                        _editedValues['password'] = value;
                      },
                    ),
              Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        Text('Role'),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: Role.patient,
                                  groupValue: _roleValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['role'] = "PATIENT";
                                      _roleValue = value;
                                    });
                                  },
                                ),
                                Text('Patient'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: Role.mdt,
                                  groupValue: _roleValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['role'] = "MDT";
                                      _roleValue = value;
                                    });
                                  },
                                ),
                                Text('MDT'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: Role.admin,
                                  groupValue: _roleValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['role'] = "ADMIN";
                                      _roleValue = value;
                                    });
                                  },
                                ),
                                Text('Admin'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Text('AccountNonLocked'),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: AccountNonLocked.locked,
                                  groupValue: _accountNonLockedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['accountNonLocked'] = 0;
                                      _accountNonLockedValue = value;
                                    });
                                  },
                                ),
                                Text('Locked')
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: AccountNonLocked.unlocked,
                                  groupValue: _accountNonLockedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['accountNonLocked'] = 1;
                                      _accountNonLockedValue = value;
                                    });
                                  },
                                ),
                                Text('NonLocked')
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Text('AccountNonExpired'),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: AccountNonExpired.expired,
                                  groupValue: _accountNonExpiredValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['accountNonExpired'] = 0;
                                      _accountNonExpiredValue = value;
                                    });
                                  },
                                ),
                                Text('Expired'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: AccountNonExpired.nonexpired,
                                  groupValue: _accountNonExpiredValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['accountNonExpired'] = 1;
                                      _accountNonExpiredValue = value;
                                    });
                                  },
                                ),
                                Text('NonExpired')
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Text('CredentialsNonExpired'),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: CredentialsNonExpired.expired,
                                  groupValue: _credentialsNonExpiredValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['credentialsNonExpired'] =
                                          0;
                                      _credentialsNonExpiredValue = value;
                                    });
                                  },
                                ),
                                Text('Expired')
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: CredentialsNonExpired.nonexpired,
                                  groupValue: _credentialsNonExpiredValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['credentialsNonExpired'] =
                                          1;
                                      _credentialsNonExpiredValue = value;
                                    });
                                  },
                                ),
                                Text('NonExpired'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Text('Enabled'),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: AccountEnabled.disabled,
                                  groupValue: _accountEnabledValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['enabled'] = 0;
                                      _accountEnabledValue = value;
                                    });
                                  },
                                ),
                                Text('NonEnabled'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Radio(
                                  value: AccountEnabled.enabled,
                                  groupValue: _accountEnabledValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _editedValues['enabled'] = 1;
                                      _accountEnabledValue = value;
                                    });
                                  },
                                ),
                                Text('Enabled'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
