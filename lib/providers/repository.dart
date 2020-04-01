import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './item.dart';
import './comment.dart';

class Repository with ChangeNotifier {
  final _token;
  final _userId;
  final Map<String, String> _mapToken = {};
  // _mapToken['authorization'] = 'token';

  //{'authorization': _token};

  var _repoItems = [];
  var _repoFiltersMap = {
    'articles': true,
    'audio': true,
    'news': false,
    'stories': false,
    'videos': false,
  };

  Repository(this._token, this._userId);

  Map<String, String> get tokenHeader {
    return {'authorization': _token};
  }

  // Future<void> editRepoItem(Map<String, String> itemData) async {
  Future<void> editRepoItem(Item item) async {
    print('repo.editRepoItem\n\n');
    print(item.toString());

    final url = 'http://10.0.2.2:8080/posts/';
    try {
      final response = await http.post(
        url,
        headers: tokenHeader,
        body: json.encode(
          {
            'title': item.title,
            'description': item.description,
            'media': item.media,
            'category': item.category,
            'link_url': item.link_url,
            'image_url': item.image_url,
          },
        ),
      );
      print("editRepo:" + response.body.toString() + "\n");
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchItems() async {
    var url = 'http://10.0.2.2:8080/users/$_userId/posts';

    try {
      var response = await http.get(url, headers: tokenHeader);
      final items = json.decode(response.body);
      final List<Item> _fetchedItems = [];

      items.forEach((post) {
        _fetchedItems.add(
          Item(
            id: post["id"],
            media: post["media"],
            category: post["category"],
            title: post["title"],
            description: post["description"],
            link_url: post["linkUrl"],
            image_url: post["imageUrl"],
            
          ),
        );
      });

      _repoItems = _fetchedItems;

      // final itemComments = json.decode(response.body) as Map<String, dynamic>;

      // itemDetailsResponse.forEach(
      //   (id, itemMap) {
      //     final List<Comment> _fetchedComments = [];
      //     if(itemComments != null) {
      //     if (itemComments[id] != null) {
      //       itemComments[id]['comments'].forEach((key, map) {

      //         _fetchedComments.add(Comment(
      //           id: key,
      //           text: map['commentText'],
      //           // dateTime: map['dateTime'],
      //           dateTime: DateTime.now(),
      //           imageUrl: map['imageUrl'],
      //           authorName: map['authorName'],
      //         ));
      //       });
      //     }
      //   }
      //     _fetchedItems.add(
      //       Item(
      //         category: itemMap['category'],
      //         description: itemMap['description'],
      //         id: id,
      //         media: itemMap['media'],
      //         title: itemMap['title'],
      //         linkUrl: itemMap['linkUrl'],
      //         imageUrl: itemMap['imageUrl'],
      //         comments: _fetchedComments,
      //       ),
      //     );
      //   },
      // );

      notifyListeners();

      fetchComments();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> fetchComments() async {
    var url = 'http://10.0.2.2:8080/users/$_userId/comments';
    try {
      var response = await http.post(
        url,
        headers: tokenHeader,
        body: json.encode(
          {
            "userId": _userId,
          },
        ),
      );
      final items = json.decode(response.body);
      print("fetching comments: $items");
    } catch (e) {
      e.toString();
    }
  }

  Future<void> saveComment(Comment comment) async {
    final url = 'http://10.0.2.2:8080/$_userId/comments/';
    print("in saveComment: ${comment.postId}");
    try {
      final response = await http.post(
        url,
        headers: tokenHeader,
        body: json.encode(
          {
            // "userId": _,
            "postId": comment.postId,
            "textBody": "testComment",
          },
        ),
      );
      notifyListeners();
      print(response.body.toString());
    } catch (error) {
      throw error;
    }
  }

  Item findById(String id) {
    return _repoItems.firstWhere((element) => element.id == id);
  }

  List<Item> get items {
    return [..._repoItems];
  }

  // Future<void> getFetchRepoItems() async {
  //   var url = 'https://fyp-palliative-care.firebaseio.com/repoItems.json?auth=$authToken';
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     final List<Item> loadedRepoItems = [];
  //     if (extractedData == null) return;
  //     url = 'https://fyp-palliative-care.firebaseio.com/products.json?auth=$authToken';
  //     final repoSettingsResponse = await http.get(url);
  // }

  Map<String, bool> get repositoryFilters {
    return Map.from(_repoFiltersMap);
  }

  void saveRepositoryFilters(Map<String, bool> selectedRepoFilters) {
    _repoFiltersMap = selectedRepoFilters;
  }
}
