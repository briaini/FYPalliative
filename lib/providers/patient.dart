import 'package:flutter/foundation.dart';

class Patient with ChangeNotifier {
  final int _id;
  final String _name;
  final _posts;

  Patient(this._id, this._name, this._posts);

  get name {
    return _name;
  }

  get id {
    return _id;
  }

  get posts {
    return [..._posts];
  }
}