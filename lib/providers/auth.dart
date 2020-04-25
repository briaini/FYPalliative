import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  String _username;
  String _token;
  int _userId;
  DateTime _expiryDate;
  Timer _authTimer;
  bool _isAdmin = false;
  bool _isMDT = false;
  String _role;

  bool get isAuth {
    return token != null;
  }

  String get role {
    return _role ;
  }

  bool get isAdmin {
    return _isAdmin;
  }

  bool get isPatient {
    return (!(isAdmin || isMDT));
  }


  bool get isMDT {
    return _isMDT;
  }

  Map<String, String> get tokenHeader {
    return {'authorization': _token};
  }

  String get token {
    // if (_expiryDate != null &&
    //     _expiryDate.isAfter(DateTime.now()) &&
    //     _token != null) {
    return _token;
    // }
    // return null;
  }

  int get userId {
    return _userId;
  }

  String get expiryDate {
    return _expiryDate.toString();
  }

  String get authTimer {
    return _authTimer.toString();
  }

  Future<void> signup(String username, String password) async {
    final url = 'http://10.0.2.2:8080/users';
    try {
      final response = await http.post(
        url,
        headers: {
          //           //error status 415 without headers
          // "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(
          {
            "username": username,
            "password": password,
            "role": "PATIENT",
            "accountNonExpired": 1,
            "accountNonLocked": 1,
            "credentialsNonExpired": 1,
            "enabled": 1
          }, //TODO: change static
        ),
      );

      await authenticate(username, password);
    } catch (e) {
      e.toString();
    }
  }

  Future<void> authenticate(String username, String password) async {
    Map<String, dynamic> _parsedToken;
    String roler;
    try {
      var url = 'http://10.0.2.2:8080/login';
      var response = await http.post(
        url,
        headers: {
          //           //error status 415 without headers
          // "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(
          {"username": username, "password": password},
        ),
      );

      //Get jwt in header of http response
      _token = response.headers['authorization'];
      //Parse jwt
      _parsedToken = parseJwt(_token);

      //Store jwt claims in local variables
      _username = _parsedToken["sub"];
      print("username is: \n" + _username + "\n");
      print("token is: $_token");

      if (_parsedToken["authorities"].toString().contains("ADMIN")) {
        roler = "ADMIN";
        _isAdmin = true;
      } else if (_parsedToken["authorities"].toString().contains("MDT")) {
        roler = "MDT";
        _isMDT = true;
      } else {
        roler = "PATIENT";
      }

      response = await http.post(
        'http://10.0.2.2:8080/users/userID',
        body: _username,
      );
      _userId = int.tryParse(response.body);
      _role = roler;
      print("userID is: $_userId");
      // print("token is: \n" + _token + "\n");

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            "1000",
          ),
        ),
      );
      // _role = "ADMIN";
      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'username': _username,
          'expiryDate': _expiryDate.toIso8601String(),
          'isMDT': _isMDT,
          'isAdmin': _isAdmin,
          'role': _role,
        },
      );
      prefs.setString('userData', userData);

      // print("is MDT: " + _isMDT.toString());
      // print("token: " + _token);
      // print("auth__userId: " + _userId);
      // print("username: " + _username);
      // print("expiry: " + _expiryDate.toString());
    } catch (e) {
      print("ERROR Auth");
      e.toString();
    }
    // _role = "ADMIN";
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore((DateTime.now()))) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    _isMDT = extractedUserData['isMDT'];
    _isAdmin = extractedUserData['isAdmin'];
    _role = extractedUserData['role'];

    _autoLogout();
    notifyListeners();

    return true;
  }

  void logout() async {
    print("logging out");
    _token = null;
    _userId = null;
    _expiryDate = null;
    _isAdmin = false;
    _isMDT = false;
    _role = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');
      prefs.clear();
    } catch (error) {
      print("error clearing shared pref");
    }
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
