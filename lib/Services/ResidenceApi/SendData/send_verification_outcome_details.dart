import 'dart:convert';

import 'package:radium_tech/Services/base_url.dart';
import 'package:http/http.dart' as http;

class SendVerificationOutcomeDetails {
  BaseUrl baseUrl = BaseUrl();

  sendVerificationOutcomeDetails(data, appUrl) async {
    String fullUrl = baseUrl.url + appUrl;
    var completeUrl = Uri.parse(fullUrl);
    return await http.post(completeUrl,
        body: jsonEncode(data), headers: baseUrl.setHeaders());
  }
}
