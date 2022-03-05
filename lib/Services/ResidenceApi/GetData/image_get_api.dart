import 'dart:convert';

import 'package:radium_tech/Model/ResidenceModel/get_image_data.dart';
import 'package:radium_tech/Services/base_url.dart';
import 'package:http/http.dart' as http;
class ImageGet {
   BaseUrl baseUrl = BaseUrl();
  Future<ImageResponse> getImageResponse(appUrl) async {
    var client = http.Client();
    var welcomeMale;
    try {
      var response = await client.get(Uri.parse(baseUrl.url + appUrl));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response);
        var jsonResponse = response.body;
        var jsonMap = json.decode(jsonResponse);
        print(jsonMap);
        var imageDataResponse = jsonMap['data'];

        var jsonMapResponse = json.decode(jsonResponse);

        welcomeMale = ImageResponse.fromJson(jsonMap);
      }
    } catch (Exception) {
      welcomeMale;
    }
    return welcomeMale;
  }
}
