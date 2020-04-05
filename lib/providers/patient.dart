import 'package:flutter/foundation.dart';

class Patient with ChangeNotifier {
  final int _id;
  final String _name;

  Patient(this._id, this._name);

  get name {
    return _name;
  }
}