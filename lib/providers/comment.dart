import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Comment {
  final _id;
  final _subjectId;
  final _subjectName;
  final _textBody;
  final _postId;
  final _parentCommentId;
  final _time;

  // DateTime dateTime;

  Comment(
    this._id,
    this._subjectId,
    this._subjectName,
    this._textBody,
    this._postId,
    this._parentCommentId,
    this._time,
  );

  int get id {
    return _id;
  }

  int get subjectId {
    return _subjectId;
  }

  get time {
    DateTime mytime = new DateFormat("yyyy-MM-dd'T'H':'m':'s'").parse(_time);
    return new DateFormat("dd-MM-yyyy hh:mm").format(mytime);
  }

  String get textBody {
    return _textBody;
  }

  String get subjectName {
    return _subjectName;
  }

  int get postId {
    return _postId;
  }

  int get parentCommentId {
    return _parentCommentId;
  }
}
