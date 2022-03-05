import 'dart:convert';

import 'package:radium_tech/Services/base_url.dart';
import 'package:http/http.dart' as http;

class SubmitApi {
  BaseUrl baseUrl = BaseUrl();

  submilData( appUrl) async {
    String fullUrl = baseUrl.url + appUrl;
    var completeUrl = Uri.parse(fullUrl);
    return await http.post(completeUrl,
         headers: baseUrl.setHeaders());
  }
}
