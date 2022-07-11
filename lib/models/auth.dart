import 'dart:convert';

import 'package:clothes_store/exception/auth_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const _url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  Future<void> authenticate(
      String email, String password, String method) async {
    final result = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$method?key=AIzaSyBjsZdZVBaTcR4_-_ZPcHE3XG2ZTeI9rXY'),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    final body = jsonDecode(result.body);
    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }
  }

  Future<void> signup(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }
}
