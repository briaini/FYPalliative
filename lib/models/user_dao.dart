import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class UserDAO with ChangeNotifier {
  final _id;
  final _name;
  final _role;

  UserDAO(this._id, this._name, this._role);

  get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get role {
    return _role;
  }

  @override
  String toString() {
    return 
    """
     id: $_id,
     name: $_name,
     role: $_role,

    """;
  }
}