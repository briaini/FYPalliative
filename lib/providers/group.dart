import 'package:flutter/foundation.dart';

import './comment.dart';
import './item.dart';
import '../models/user_dao.dart';

class Group with ChangeNotifier {
  final _id;
  final _name;
  final _members;
  final List<Item> _posts;
  final _comments;
  final _mdt;

  Group(
    this._id,
    this._name,
    this._members,
    this._posts,
    this._comments,
    this._mdt,
  );

  @override
  String toString() {
    return """
    id: $_id,
    name: $_name,
    members: $_members,
    posts: $_posts,
    """;
  }

  get isMdt {
    return _mdt;
  }

  get id {
    return _id;
  }

  get name {
    return _name;
  }

  List<UserDAO> get members {
    return _members;
  }

  List<Item> get posts {
    return _posts;
  }

  List<Comment>get comments {
    return _comments ?? [];
  }
}
