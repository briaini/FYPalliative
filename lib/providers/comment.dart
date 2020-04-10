import 'package:flutter/foundation.dart';

class Comment {
  final _id;
  final _subjectId;
  final _textBody;
  final _postId;
  final _parentCommentId;

  // DateTime dateTime;

  Comment(
    this._id,
    this._subjectId,
    this._textBody,
    this._postId,
    this._parentCommentId,
  );

  int get id {
    return _id;
  }

  int get subjectId {
    return _subjectId;
  }

  String get textBody {
    return _textBody;
  }

  int get postId {
    return _postId;
  }

  int get parentCommentId {
    return _parentCommentId;
  }
}
