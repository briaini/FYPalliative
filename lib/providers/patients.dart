import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/user_dao.dart';
import './comment.dart';
import './item.dart';
import './group.dart';
import './patient.dart';
import '../utils/http_service.dart';

class Patients with ChangeNotifier {
  String _token;
  int _userId;
  List<UserDAO> _patients = [];
  // List<UserDAO> _unassignedPatients = [];
  List<UserDAO> _users = [];
  List<Group> _groups = [];
  List<Group> _nonMdtGroups = [];
  List<UserDAO> _mdtusers = [];
  List<UserDAO> _patientusers = [];
  String test = 'hello';
  List<String> testArray = ['hi', 'hallo', 'bye'];

  SingletonHttp singletonHttp;

  Patients(this._token, this._userId, this._patients);

  String get getTest {
    return test;
  }

  addToTestArray(newString) {
    testArray.add(newString);
    notifyListeners();
  }

  List<String> get tstArray {
    return [...testArray];
  }

  editString(newString) {
    test = newString;
    notifyListeners();
  }

  Map<String, String> get tokenHeader {
    return {'authorization': _token};
  }

//patients only returns users/patients assigned to a specific mdt worker
  List<UserDAO> get patients {
    return _patients;
  }

  List<Group> get groups {
    return [..._groups] ?? [];
  }

  List<Group> get nonMdtGroups {
    return [..._nonMdtGroups] ?? [];
  }

  List<Group> get mdtGroups {
    return groups.where((group) => group.isMdt).toList() ?? [];
  }

  List<Group> get mdtGroupsWithPatient {
    return groups == null
        ? []
        : _groups
                .where((group) =>
                    group.isMdt &&
                    group.members.any((user) => user.role == "PATIENT"))
                .toList() ??
            [];
  }

  Group findGroupById(id) {
    return groups.firstWhere((group) => group.id == id);
  }

  Group findNonMdtGroupById(id) {
    print('in findnonmdtgroupbyid id: $id ');
    print(nonMdtGroups.map((e) => e.id).toList());
    return nonMdtGroups.firstWhere((group) => group.id == id);
  }

  List<Group> findGroupsByMdtId(id) {
    return _groups
            .where((group) =>
                group.members.any((user) => user.id == id))
            .toList() ??
        [];
  }

  // List<UserDAO> get newUnassignedPatientUsers {
  //   return [..._unassignedPatients];
  // }

  List<UserDAO> get unassignedPatientUsers {
    final mdtGroupsWithPatient = _groups
        .where((group) =>
            group.isMdt && group.members.any((user) => user.role == "PATIENT"))
        .toList();

    final assignedPatientIds = mdtGroupsWithPatient
        .map((e) =>
            e.members.singleWhere((element) => element.role == "PATIENT").id)
        .toList();

    return users
        .where((user) =>
            user.role == "PATIENT" && !assignedPatientIds.contains(user.id))
        .toList();
    // return users;
  }

  List<UserDAO> get patientusers {
    _patientusers =
        _users.where((element) => element.role == 'PATIENT').toList();
    return _patientusers;
  }

  List<UserDAO> get mdtworkers {
    _mdtusers = _users.where((element) => element.role == 'MDT').toList();
    return _mdtusers;
  }

  List<UserDAO> get users {
    return _users;
  }

  Future<String> adminFetchUser(userId) async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/users/admin/$userId';
    try {
      var response = await singletonHttp.getIoc().get(
            url,
            headers: tokenHeader,
          );

      // final response = await http.get(
      //   url,
      //   headers: tokenHeader,
      // );
      // final extractedData = json.decode(response.body) as List<dynamic>;
      // if (extractedData == null) {
      //   print("extracted patients null");
      //   return "";
      // }

      return response.body;
    } catch (e) {}
  }

  Future<void> fetchUsers() async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/users';
    try {
      final response = await singletonHttp.getIoc().get(
            url,
            headers: tokenHeader,
          );

      // final response = await http.get(
      //   url,
      //   headers: tokenHeader,
      // );
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        print("extracted patients null");
        _users = [];
        return;
      }
      final List<UserDAO> loadedUsers = [];

      extractedData.forEach((user) {
        loadedUsers.add(
          UserDAO(
            user['id'],
            user['username'],
            user['role'],
            null,
          ),
        );
      });
      _users = loadedUsers;
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteUser(userId) async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/users/$userId';
    try {
      final response = await singletonHttp.getIoc().delete(
            url,
            headers: tokenHeader,
          );
          notifyListeners();
    } catch (e) {}
  }

  // Future<void> adminFetchUnassignedPatients() async {
  //   var url = 'http://10.0.2.2:8080/users/unassignedPatients';
  //   print(url);
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: tokenHeader,
  //     );
  //     final extractedData = json.decode(response.body) as List<dynamic>;
  //     if (extractedData == null) {
  //       print("extracted patients null");
  //       _patients = [];
  //       return;
  //     }
  //     final List<UserDAO> loadedPatients = [];

  //     extractedData.forEach((patient) {
  //       loadedPatients.add(
  //         UserDAO(
  //           patient['id'],
  //           patient['name'],
  //           'PATIENT',
  //           patient['mdtId'],
  //         ),
  //       );
  //     });
  //     _unassignedPatients = loadedPatients;
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  // Future<void> adminFetchAllPatients() async {
  //   var url = 'http://10.0.2.2:8080/users/patients';
  //   print(url);
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: tokenHeader,
  //     );
  //     final extractedData = json.decode(response.body) as List<dynamic>;
  //     if (extractedData == null) {
  //       print("extracted patients null");
  //       _patients = [];
  //       return;
  //     }
  //     final List<UserDAO> loadedPatients = [];

  //     extractedData.forEach((patient) {
  //       loadedPatients.add(
  //         UserDAO(
  //           patient['id'],
  //           patient['name'],
  //           'PATIENT',
  //           patient['mdtId'],
  //         ),
  //       );
  //     });
  //     _allPatients = loadedPatients;
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future<void> fetchPatients() async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/mdt/$_userId/patients';
    try {
      final response = await singletonHttp.getIoc().get(
            url,
            headers: tokenHeader,
          );
      // final response = await http.get(
      //   url,
      //   headers: tokenHeader,
      // );
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        print("extracted patients null");
        _patients = [];
        return;
      }
      final List<UserDAO> loadedPatients = [];

      extractedData.forEach((patient) {
        loadedPatients.add(
          UserDAO(
            patient['id'],
            patient['name'],
            'PATIENT',
            patient['mdtId'],
          ),
        );
      });
      _patients = loadedPatients;
    } catch (error) {
      print("error");
    }
  }

  Future<void> addGroup(newGroup) async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/groups';
    try {
      final response = await singletonHttp.getIoc().post(
            url,
            headers: tokenHeader,
            body: json.encode({
              "name": newGroup['name'],
              "isMdt": newGroup['isMdt'],
            }),
          );
      // final response = await http.post(
      //   url,
      //   headers: tokenHeader,
      //   body: json.encode(
      //     {
      //       "name": newGroup['name'],
      //       "isMdt": newGroup['isMdt'],
      //     },
      //   ),
      // );
      notifyListeners();
    } catch (e) {
      print("Error adding group");
    }
  }

  Future<void> deleteGroup(groupId) async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/groups/$groupId';
    try {
      final response = await singletonHttp.getIoc().delete(
            url,
            headers: tokenHeader,
          );
      // final response = await http.delete(
      //   url,
      //   headers: tokenHeader,
      // );

      print(response);
    } catch (e) {}
  }

//TODO: implement user specific groups in backend, currently fetching all groups
  Future<void> fetchGroups() async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/mdt/$_userId/groups';
    final List<Group> loadedGroups = [];
    try {
      final response = await singletonHttp.getIoc().get(
            url,
            headers: tokenHeader,
          );
      // final response = await http.get(
      //   url,
      //   headers: tokenHeader,
      // );
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        _groups = [];
        return;
      }
      extractedData.forEach((group) {
        loadedGroups.add(
          Group(
            group['id'],
            group['name'],
            (group['members'] as List<dynamic>)
                .map(
                  (user) => UserDAO(
                    user['id'],
                    user['name'],
                    user['role'],
                    null,
                  ),
                )
                .toList(),
            (group['posts'] as List<dynamic>)
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
            (group['hiddenposts'] as List<dynamic>)
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
            group['recipient'] == null
                ? []
                : (group['recipient']['comments'] as List<dynamic>)
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
          ),
        );
      });
      _groups = loadedGroups;

      _nonMdtGroups =
          loadedGroups.where((group) => group.isMdt == false).toList();
      notifyListeners();
    } catch (error) {
      print("error");
    }
  }

  Future<void> fetchMyGroups() async {
    singletonHttp = SingletonHttp();
    var url = 'https://10.0.2.2:44301/mdt/$_userId/mygroups';
    final List<Group> loadedGroups = [];
    try {
      final response = await singletonHttp.getIoc().get(
            url,
            headers: tokenHeader,
          );
      // final response = await http.get(
      //   url,
      //   headers: tokenHeader,
      // );
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        _groups = [];
        return;
      }
      extractedData.forEach((group) {
        loadedGroups.add(
          Group(
            group['id'],
            group['name'],
            (group['members'] as List<dynamic>)
                .map(
                  (user) => UserDAO(
                    user['id'],
                    user['name'],
                    user['role'],
                    null,
                  ),
                )
                .toList(),
            (group['posts'] as List<dynamic>)
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
            (group['hiddenposts'] as List<dynamic>)
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
            group['recipient'] == null
                ? []
                : (group['recipient']['comments'] as List<dynamic>)
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
          ),
        );
      });

      _groups = loadedGroups.where((group) => group.isMdt == true).toList();

      _nonMdtGroups =
          loadedGroups.where((group) => group.isMdt == false).toList();

      notifyListeners();
    } catch (error) {
      print("error");
    }
  }

  Future<void> linkUserToGroup(groupId, userId) async {
    singletonHttp = SingletonHttp();
    final url = 'https://10.0.2.2:44301/groups/$groupId/users/$userId';
    try {
      final response = await singletonHttp.getIoc().post(
            url,
            headers: tokenHeader,
          );
      // final response = await http.post(
      //   url,
      //   headers: tokenHeader,
      // );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> linkPostToPatient(patientId, postId) async {
    singletonHttp = SingletonHttp();
    final url = 'https://10.0.2.2:44301/users/$patientId/posts/$postId';
    try {
      final response = await singletonHttp.getIoc().post(
            url,
            headers: tokenHeader,
          );
      // final response = await http.post(
      //   url,
      //   headers: tokenHeader,
      // );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> linkPostToGroup(groupId, postId) async {
    singletonHttp = SingletonHttp();
    final url = 'https://10.0.2.2:44301/groups/$groupId/posts/$postId';
    try {
      final response = await singletonHttp.getIoc().get(
            url,
            headers: tokenHeader,
          );
      // final response = await http.post(
      //   url,
      //   headers: tokenHeader,
      // );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> hidePostFromGroup(postId) async {
    singletonHttp = SingletonHttp();
    final url = 'https://10.0.2.2:44301/users/$_userId/hiddenposts/$postId';
    try {
      final response = await singletonHttp.getIoc().post(
            url,
            headers: tokenHeader,
          );
      // final response = await http.post(
      //   url,
      //   headers: tokenHeader,
      // );

      notifyListeners();
      // print(response.body.toString());
    } catch (error) {
      throw error;
    }
  }

  Future<void> mdtSwapGroupPostVisibility(postId, Group g) async {
    singletonHttp = SingletonHttp();
    var url = 'hi';
    if (g.posts.any((post) => post.id == postId)) {
      url = 'https://10.0.2.2:44301/groups/${g.id}/hiddenposts/$postId';
    } else {
      url = 'https://10.0.2.2:44301/groups/${g.id}/visibleposts/$postId';
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

  Future<void> saveMessage(groupId, commentText) async {
    singletonHttp = SingletonHttp();
    final url = 'https://10.0.2.2:44301/groups/$groupId/messages';
    try {
      final response = await singletonHttp.getIoc().post(
            url,
            body: json.encode(
              {
                "textBody": commentText,
                "subjectId": _userId,
              },
            ),
            headers: tokenHeader,
          );

      // final response = await http.post(
      //   url,
      //   headers: tokenHeader,
      //   body: json.encode(
      //     {
      //       "textBody": commentText,
      //       "subjectId": _userId,
      //     },
      //   ),
      // );
      // print(response.body.toString());
      // fetchGroup();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
