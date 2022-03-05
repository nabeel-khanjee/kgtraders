import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

var changeUrl;

class BaseUrl {
  var url = "http://192.168.18.65:8000";
  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!)['token'];
  }
}
