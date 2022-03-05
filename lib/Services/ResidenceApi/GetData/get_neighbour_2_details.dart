import 'dart:convert';

import 'package:radium_tech/Model/ResidenceModel/get_neighbour_2_data.dart';
import 'package:radium_tech/Services/base_url.dart';
import 'package:http/http.dart' as http;

class GetNeighbour2Details {
  BaseUrl baseUrl = BaseUrl();

  Future<GetNeighbour2Data> getResidenceDetails(appUrl) async {
    var now = null;

    String fullUrl = baseUrl.url + appUrl;
    var completeUrl = Uri.parse(fullUrl);
    try {
      final http.Response response =
          await http.get(Uri.parse(baseUrl.url + appUrl));

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        return GetNeighbour2Data.fromJson(jsonDecode(response.body));
      } else {
        return now;
      }
    } catch (e) {
      throw Exception("Unknown Error");
    }
  }
}
