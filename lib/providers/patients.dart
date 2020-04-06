import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './patient.dart';

class Patients with ChangeNotifier {
  String _token;
  int _userId;
  List<Patient> _patients = [];

  Patients(this._token, this._userId, this._patients);

  Map<String, String> get tokenHeader {
    return {'authorization': _token};
  }

  List<Patient> get patients {
    return [..._patients];
  }

  Future<void> fetchPatients() async {
    var url = 'http://10.0.2.2:8080/users/$_userId/patients';
    try {
      final response = await http.get(
        url,
        headers: tokenHeader,
      );
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) return;
      final List<Patient> loadedPatients = [];

      extractedData.forEach((patient) {
        loadedPatients.add(
          Patient(
            patient['id'],
            patient['name'],
            patient['posts'],
            patient['comments'],
            patient['mdt'],
          ),
        );
      });
      _patients = loadedPatients;
    } catch (error) {
      print(error);
    }
  }

  Future<void> linkPostToPatient(patientId, postId) async {
    final url =
        // 'http://10.0.2.2:8080/users/0/posts/31';
        'http://10.0.2.2:8080/users/$patientId/posts/$postId';
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
