import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const _url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  Future<void> signup(String email, String password) async {
    final result = await http.post(
      Uri.parse('${_url}signUp?key=AIzaSyBjsZdZVBaTcR4_-_ZPcHE3XG2ZTeI9rXY'),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(jsonDecode(result.body));
  }

  Future<void> login(String email, String password) async {
    final result = await http.post(
      Uri.parse(
          '${_url}signInWithPassword?key=AIzaSyBjsZdZVBaTcR4_-_ZPcHE3XG2ZTeI9rXY'),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(jsonDecode(result.body));
  }
}
