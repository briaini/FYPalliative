import 'package:flutter/foundation.dart';

class Comment {
  final int id;
  final int postId;
  final int userId;
  final String textBody;
  DateTime dateTime;

  Comment({
    this.id,
    @required this.postId,
    @required this.textBody,
    this.userId,
    this.dateTime,
  });
}
