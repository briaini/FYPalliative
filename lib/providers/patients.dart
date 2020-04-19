import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/user_dao.dart';
import './comment.dart';
import './item.dart';
import './group.dart';
import './patient.dart';

class Patients with ChangeNotifier {
  String _token;
  int _userId;
  List<Patient> _patients = [];
  List<UserDAO> _users = [];
  List<Group> _groups;

  Patients(this._token, this._userId, this._patients);

  Map<String, String> get tokenHeader {
    return {'authorization': _token};
  }

  List<Patient> get patients {
    return _patients;
  }

  List<UserDAO> get users {
    return _users;
  }

  Future<void> fetchUsers() async {
    var url = 'http://10.0.2.2:8080/users';
    print(url);
    try {
      final response = await http.get(
        url,
        headers: tokenHeader,
      );
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
          ),
        );
      });
      _users = loadedUsers;
      print('feteched users ...........................');
      print(_users);
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchPatients() async {
    var url = 'http://10.0.2.2:8080/mdt/$_userId/patients';
    print(url);
    try {
      final response = await http.get(
        url,
        headers: tokenHeader,
      );
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        print("extracted patients null");
        _patients = [];
        return;
      }
      final List<Patient> loadedPatients = [];

      extractedData.forEach((patient) {
        loadedPatients.add(
          Patient(
            patient['id'],
            patient['name'],
            patient['mdtId'],
          ),
        );
      });
      _patients = loadedPatients;
    } catch (error) {
      print(error);
    }
  }

  Future<void> addGroup(newGroup) async {
    var url = 'http://10.0.2.2:8080/groups';
    try {
      final response = await http.post(
        url,
        headers: tokenHeader,
        body: json.encode(
          {
            "name": newGroup['name'],
            "isMdt": newGroup['isMdt'],
          },
        ),
      );
      notifyListeners();
      print(response.body.toString());
    } catch (e) {
      print("Error adding group");
    }
  }

//TODO: implement user specific groups in backend, currently fetching all groups
  Future<void> fetchGroups() async {
    print("tst group");
    var url = 'http://10.0.2.2:8080/mdt/$_userId/groups';
    print(url);
    final List<Group> loadedGroups = [];
    try {
      final response = await http.get(
        url,
        headers: tokenHeader,
      );
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
            group['recipient'] == null
                ? []
                : (group['recipient']['comments'] as List<dynamic>)
                    .map(
                      (comment) => Comment(
                        comment['id'],
                        comment['subjectId'],
                        comment['textBody'],
                        comment['postId'],
                        comment['parentCommentId'],
                      ),
                    )
                    .toList(),
          ),
        );
      });
      _groups = loadedGroups;
    } catch (error) {
      print(error);
    }
  }

  List<Group> get groups {
    return _groups ?? [];
  }

  Future<void> linkUserToGroup(groupId, userId) async {
    print('groupid: $groupId');
    print('userid: $userId');
    final url = 'http://10.0.2.2:8080/groups/$groupId/users/$userId';
    try {
      final response = await http.post(
        url,
        headers: tokenHeader,
      );
      notifyListeners();
      print(response.body.toString());
    } catch (error) {
      throw error;
    }
  }

  Future<void> linkPostToPatient(patientId, postId) async {
    final url = 'http://10.0.2.2:8080/users/$patientId/posts/$postId';
    try {
      final response = await http.post(
        url,
        headers: tokenHeader,
      );

      notifyListeners();
      print(response.body.toString());
    } catch (error) {
      throw error;
    }
  }
}
