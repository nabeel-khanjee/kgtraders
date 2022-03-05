import 'dart:convert';

import 'package:radium_tech/Services/base_url.dart';
import 'package:http/http.dart' as http;

class SendMarketCheck1Details {
  BaseUrl baseUrl = BaseUrl();

  sendMarketCheck1Details(data, appUrl) async {
    String fullUrl = baseUrl.url + appUrl;
    var completeUrl = Uri.parse(fullUrl);
    return await http.post(completeUrl,
        body: jsonEncode(data), headers: baseUrl.setHeaders());
  }
}
