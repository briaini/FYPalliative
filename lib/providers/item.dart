import 'package:flutter/foundation.dart';

import './comment.dart';

class Item with ChangeNotifier {
  int id;
  final String media;
  final String category;
  final String title;
  final String description;
  final String linkUrl;
  final String imageUrl;
  List<Comment> comments = [];

  Item({
    this.id,
    @required this.media,
    @required this.category,
    @required this.title,
    @required this.description,
    @required this.linkUrl,
    @required this.imageUrl,
    this.comments,
  });

  int get getId{
    return id;
  }

  List<Comment> get getComments {
    return comments;
  }

  void addComment(Comment comment) {
    comments.add(comment);
  }

  @override
  String toString() {
    return """Printing Item: 
    {
      'id':'$id',
      'media':'$media,
      'category':'$category,
      'title':'$title,
      'description':'$description,
      'linkUrl':'$linkUrl,
      'imageUrl':'$linkUrl,
      'comments':${comments.toString()}
    }    
    """;
  }
}
