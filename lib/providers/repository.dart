import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './item.dart';
import './comment.dart';
import '../widgets/new_comment_modal.dart';


class Repository with ChangeNotifier {
  final _token;
  final _userId;
  final Map<String, String> _mapToken = {};
  List<Comment> _comments;
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

  Repository(this._token, this._userId, this._repoItems);

  Map<String, String> get tokenHeader {
    return {'authorization': _token};
  }

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
            "title": item.title,
            "media": item.media,
            "category": item.category,
            "description": item.description,
            "link_url": item.linkUrl,
            "image_url": item.imageUrl,
          },
        ),
      );
      print("editRepo:" + response.body.toString() + "\n");
      notifyListeners();
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

      url = 'http://10.0.2.2:8080/users/$_userId/comments';
      response = await http.get(
        url,
        headers: tokenHeader,
      );
      final comments = json.decode(response.body);
      List<Comment> fetchedComments = [];

      comments.forEach((comment) {
        fetchedComments.add(
          Comment(
            id: comment['id'],
            textBody: comment['textBody'],
            postId: comment["post"]["id"],
          ),
        );
      });

      items.forEach((post) {
        _fetchedItems.add(
          Item(
            id: post["id"],
            media: post["media"],
            category: post["category"],
            title: post["title"],
            description: post["description"],
            linkUrl: post["link_url"],
            imageUrl: post["image_url"],
            comments: [],
          ),
        );
      });

      fetchedComments.forEach((comment) {
        _fetchedItems.forEach((item) {
            if(comment.getPostId == item.id) {
              item.comments.add(comment);
            }
         });
      });

      _repoItems = _fetchedItems;

      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  void createComment(BuildContext context, Item item) {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) {
        return NewCommentModal(item);
      },
    );
  }

  Future<void> saveComment(Comment comment) async {
    final url =
        'http://10.0.2.2:8080/users/$_userId/posts/${comment.postId}/comments';
    try {
      final response = await http.post(
        url,
        headers: tokenHeader,
        body: json.encode(
          {
            "textBody": comment.textBody,
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
