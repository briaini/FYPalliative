import 'package:flutter/foundation.dart';

import './comment.dart';

class Patient with ChangeNotifier {
  final int _id;
  final String _name;
  final _mdt;

  // final _posts;
  // final _comments;

  Patient(this._id, this._name, this._mdt);

  // Patient(this._id, this._name, this._posts, this._comments, this._mdt);

  get name {
    return _name;
  }

  get id {
    return _id;
  }

  get mdtId {
    return _mdt;
  }

  get posts {
    return [];
    // return [..._posts];
  }

  // get comments {
  //   return _comments;
  // }
}