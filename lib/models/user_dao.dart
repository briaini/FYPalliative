import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class UserDAO with ChangeNotifier {
  final _id;
  final _name;
  final _role;
  final _mdt;

  UserDAO(this._id, this._name, this._role, this._mdt);

  get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get role {
    return _role;
  }

  String get mdtId {
    return _mdt;
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