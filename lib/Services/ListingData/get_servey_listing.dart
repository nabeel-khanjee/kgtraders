import 'dart:convert';

import 'package:radium_tech/Model/task_listing_model.dart';
import 'package:radium_tech/Services/base_url.dart';
import 'package:http/http.dart'  as http;
class GetSurveyListing {
   BaseUrl baseUrl = BaseUrl();
  Future<Welcome> getList(appUrl) async {
    var client = http.Client();
    var welcomeMale;
    try {
      var response = await client.get(Uri.parse(baseUrl.url + appUrl));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        print(jsonResponse);
        var jsonMap = json.decode(jsonResponse);
        print(jsonMap);
        var jsonMapResponse = json.decode(jsonResponse);
        print(jsonMapResponse);

        welcomeMale = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      welcomeMale;
    }
    return welcomeMale;
  }
}
