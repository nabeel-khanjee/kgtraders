import 'dart:convert';

import 'package:radium_tech/Model/BankStatement/get_bank_verification_data.dart';
import 'package:radium_tech/Model/ResidenceModel/get_applicant_data.dart';
import 'package:radium_tech/Services/base_url.dart';
import 'package:http/http.dart' as http;

class GetBankVerificationDetails {
  BaseUrl baseUrl = BaseUrl();

  Future<GetBankVerificationData> getResidenceDetails(appUrl) async {
    var now = null;

    String fullUrl = baseUrl.url + appUrl;
    var completeUrl = Uri.parse(fullUrl);
    try {
      final http.Response response =
          await http.get(Uri.parse(baseUrl.url + appUrl));

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        return GetBankVerificationData.fromJson(jsonDecode(response.body));
      } else {
        return now;
      }
    } catch (e) {
      throw Exception("Unknown Error");
    }
  }
}
