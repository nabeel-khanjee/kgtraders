import 'dart:convert';

import 'package:radium_tech/Model/ResidenceModel/get_residence_data.dart';
import 'package:radium_tech/Model/WorkPlaceModel/get_market_check_1_data.dart';
import 'package:radium_tech/Model/WorkPlaceModel/get_salary_slip_data.dart';
import 'package:radium_tech/Model/WorkPlaceModel/get_workplace_data.dart';
import 'package:radium_tech/Services/base_url.dart';
import 'package:http/http.dart' as http;

class GetSalaryDetails {
  BaseUrl baseUrl = BaseUrl();

  Future<GetSalaryData> getSalaryDetails(appUrl) async {
    var now = null;

    String fullUrl = baseUrl.url + appUrl;
    var completeUrl = Uri.parse(fullUrl);
    try {
      final http.Response response =
          await http.get(Uri.parse(baseUrl.url + appUrl));

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        return GetSalaryData.fromJson(jsonDecode(response.body));
      } else {
        return now;
      }
    } catch (e) {
      throw Exception("Unknown Error");
    }
  }
}
