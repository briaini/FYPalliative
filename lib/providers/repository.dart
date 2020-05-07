import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import './group.dart';
import './item.dart';
import './comment.dart';
import '../models/user_dao.dart';
import '../widgets/new_comment_modal.dart';
import '../utils/http_service.dart';
import '../screens/admin_tabs_screen.dart';

class Repository with ChangeNotifier {
  final _token;
  final _userId;
  final _username;
  final Map<String, String> _mapToken = {};
  final _isMDT;
  List<Comment> _comments;
  Group _group;
  SingletonHttp singletonHttp;
  FilterOptions _filterOptions = FilterOptions.Title;

  // _mapToken['authorization'] = 'token';

  //{'authorization': _token};

  var _categories = [];
  var _repoItems = [];
  // var _repoFiltersMap = {
  //   'articles': true,
  //   'audio': true,
  //   'news': false,
  //   'stories': false,
  //   'videos': false,
  // };

  var _repoFiltersMap = {'All': true};

  Repository(
      this._token, this._userId, this._username, this._isMDT, this._repoItems);

  Map<String, String> get tokenHeader {
    return {'authorization': _token};
  }

  Group get group {
    return _group;
  }

  FilterOptions get filterOptions {
    return _filterOptions;
  }

  void setFilterOptions(fo) {
    _filterOptions = fo;
    notifyListeners();
  }

  List<Item> get items {
    // _repoItems.sort((a,b) => a.category.compareTo(b.category));
    return [..._repoItems];
  }

  doNothing() {
    notifyListeners();
  }

  Future<void> createUser(userMap) async {
    // print(userMap);
    singletonHttp = SingletonHttp();

    final url = 'https://10.0.2.2:44301/users/';
    // final url = 'http://10.0.2.2:8080/users/';
    try {
      final response = await singletonHttp.getIoc().post(
            url,
            headers: tokenHeader,
            body: json.encode(userMap),
          );
    } catch (e) {
      print("error creating user");
    }
  }

  Future<void> updateUser(value) async {
    final url = 'https://10.0.2.2:44301/users/';
    // final url = 'http://10.0.2.2:8080/users/';
    singletonHttp = SingletonHttp();

    try {
      final response = await singletonHttp.getIoc().put(
            url,
            headers: tokenHeader,
            body: json.encode(
              {
                "id": value['id'],
                'username': value['username'],
                'role': value['role'],
                'accountNonExpired': value['accountNonExpired'],
                'accountNonLocked': value['accountNonLocked'],
                'credentialsNonExpired': value['credentialsNonExpired'],
                'enabled': value['enabled'],
              },
            ),
          );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addRepoItem(Item item) async {
    singletonHttp = SingletonHttp();
    final url = 'https://10.0.2.2:44301/posts/';
    // final url = 'http://10.0.2.2:8080/posts/';
    try {
      final response = await singletonHttp.getIoc().post(
            url,
            headers: tokenHeader,
            body: json.encode({
              "title": item.title,
              "media": item.media,
              "category": item.category,
              "description": item.description,
              "link_url": item.linkUrl,
              "image_url": item.imageUrl,
            }),
          );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateRepoItem(Item item) async {
    singletonHttp = SingletonHttp();
    final url = 'https://10.0.2.2:44301/posts/';
    // final url = 'http://10.0.2.2:8080/posts/';
    try {
      final response = await singletonHttp.getIoc().put(
            url,
            headers: tokenHeader,
            body: json.encode(
              {
                "id": item.id,
                "title": item.title,
                "media": item.media,
                "category": item.category,
                "description": item.description,
                "link_url": item.linkUrl,
                "image_url": item.imageUrl,
              },
            ),
          );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deletePost(postId) async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/posts/$postId';
    // var url = 'http://10.0.2.2:8080/posts/$postId';
    try {
      final response = await singletonHttp.getIoc().delete(
            url,
            headers: tokenHeader,
          );
      print(response);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> fetchGroup() async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/users/$_userId/groups';
    // var url = 'http://10.0.2.2:8080/users/$_userId/groups';
    try {
      final response = await singletonHttp.getIoc().get(
            url,
            headers: tokenHeader,
          );
      final group = json.decode(response.body) as Map<String, dynamic>;
      if (group == null) {
        print("group is null");
        return;
      }
      final groupmembers = group['members'] as List<dynamic>;
      final groupposts = group['posts'] as List<dynamic>;
      final grouphiddenposts = group['grouphiddenposts'] as List<dynamic>;
      var groupcomments;
      if (group['recipient'] != null) {
        groupcomments = group['recipient']['comments'] as List<dynamic>;
      }
      var loadedGroup = Group(
        group['id'],
        group['name'],
        groupmembers == null
            ? []
            : groupmembers
                .map(
                  (user) => UserDAO(
                    user['id'],
                    user['name'],
                    user['role'],
                    null,
                  ),
                )
                .toList(),
        groupposts == null
            ? []
            : groupposts
                .map(
                  (item) => Item(
                    id: item['id'],
                    media: item['media'],
                    category: item['category'],
                    title: item['title'],
                    description: item['description'],
                    linkUrl: item['link_url'],
                    imageUrl: item['image_url'],
                  ),
                )
                .toList(),
        grouphiddenposts == null
            ? []
            : grouphiddenposts
                .map(
                  (item) => Item(
                    id: item['id'],
                    media: item['media'],
                    category: item['category'],
                    title: item['title'],
                    description: item['description'],
                    linkUrl: item['link_url'],
                    imageUrl: item['image_url'],
                  ),
                )
                .toList(),
        groupcomments == null
            ? []
            : groupcomments
                .map(
                  (comment) => Comment(
                    comment['id'],
                    comment['subjectId'],
                    comment['subjectName'],
                    comment['textBody'],
                    comment['postId'],
                    comment['parentCommentId'],
                    comment['timestamp'],
                  ),
                )
                .toList(),
        group['mdt'],
      );

      loadedGroup.posts.forEach((post) {
        if (!_categories.contains(post.category))
          _repoFiltersMap[post.category] = true;
      });

      // _categories.forEach((category) {
      //   _repoFiltersMap[category] = true;
      // });
      _group = loadedGroup;
      _repoItems = _group.posts;
    } catch (error) {
      print("error");
    }
    notifyListeners();
  }

  Future<void> fetchItems() async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/posts';

    // var url = 'http://10.0.2.2:8080/posts';
    // _isMDT
    // ? 'http://10.0.2.2:8080/posts'
    // :
    // 'http://10.0.2.2:8080/users/$_userId/posts';

    try {
      final response = await singletonHttp.getIoc().get(
            url,
            headers: tokenHeader,
          );
      final items = json.decode(response.body);
      final List<Item> _fetchedItems = [];

      print(response);
      // url = 'http://10.0.2.2:80';

      // response = await http.get(
      //   url,
      //   headers: tokenHeader,
      // );
      // final comments = json.decode(response.body);
      // List<Comment> fetchedComments = [];

      // print("comments \n $comments \n done");

      // comments.forEach((comment) {
      //   fetchedComments.add(
      //     Comment(
      //       id: comment['id'],
      //       textBody: comment['textBody'],
      //       postId: comment["postId"],
      //       // postId: comment["post"]["id"],
      //     ),
      //   );
      // });
      _categories.clear();
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
        if (!_categories.contains(post["category"]))
          _categories.add(post["category"]);
      });

      // fetchedComments.forEach((comment) {
      //   _fetchedItems.forEach((item) {
      //       if(comment.getPostId == item.id) {
      //         item.comments.add(comment);
      //       }
      //    });
      // });

      _repoItems = _fetchedItems;

      _categories.forEach((category) {
        _repoFiltersMap[category] = true;
      });
      
      _repoFiltersMap.removeWhere((key, value) => !_categories.contains(key));
      _repoFiltersMap['All'] = true;

      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  // void createComment(BuildContext context, Item item) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (bCtx) {
  //       return NewCommentModal(item);
  //     },
  //   );
  // }

  Future<void> saveComment(_username, groupId, itemId, commentText) async {
    singletonHttp = SingletonHttp();

    final url = 'https://10.0.2.2:44301/groups/$groupId/comments';

    // final url = 'http://10.0.2.2:8080/groups/$groupId/comments';
    try {
      final response = await singletonHttp.getIoc().post(
            url,
            headers: tokenHeader,
            body: json.encode({
              "textBody": commentText,
              "postId": itemId,
              "subjectId": _userId,
              "subjectName": _username,
            }),
          );

      // print(response.body.toString());
      // fetchGroup();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> patientSwapGroupPostVisibility(postId) async {
    singletonHttp = SingletonHttp();
    var url = 'hi';
    if (group.hiddenposts.any((post) => post.id == postId)) {
      url = 'https://10.0.2.2:44301/users/$_userId/patientvisibleposts/$postId';

    } else {
      url = 'https://10.0.2.2:44301/users/$_userId/patienthiddenposts/$postId';
    }
    try {
      final response = await singletonHttp.getIoc().post(
            url,
            headers: tokenHeader,
          );
      // final response = await http.post(
      //   url,
      //   headers: tokenHeader,
      // );
      // print(response.body.toString());
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Item findById(id) {
    // print('item prov item num: $id');
    // return items.first;
    return items.firstWhere((element) => element.id == id);
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
