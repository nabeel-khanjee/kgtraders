import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radium_tech/Services/base_url.dart';

class Network {
  BaseUrl baseUrl = BaseUrl();
  // String apiUrl = "signin";
  //if you are using android studio emulator, change localhost to 10.0.2.2


  authData(data, apiUrl) async {
    String fullUrl = baseUrl.url + apiUrl;
    var completeUrl = Uri.parse(fullUrl);
    return await http.post(completeUrl,
        body: jsonEncode(data), headers: baseUrl.setHeaders());
  }


}
