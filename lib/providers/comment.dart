import 'package:flutter/foundation.dart';

class Comment {
  final int id;
  final int postId;
  final int userId;
  final String textBody;
  // var Item;
  DateTime dateTime;

  Comment({
    this.id,
    @required this.postId,
    @required this.textBody,
    this.userId,
    this.dateTime,
  });

  int get getPostId {
    return postId;
  }

  String get getTextBody {
    return textBody;
  }

  @override
  String toString() {
    return
    """
    id: $id,
    postId: $postId,
    userId: $userId,
    textBody: $textBody
    """;
  }
}
