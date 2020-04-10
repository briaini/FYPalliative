import 'package:flutter/foundation.dart';

class UserDAO {
  final _id;
  final _name;
  final _role;

  UserDAO(this._id, this._name, this._role);

  String get name {
    return _name;
  }

  String get role {
    return _role;
  }

}