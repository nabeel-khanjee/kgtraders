import 'package:radium_tech/Services/base_url.dart';
import 'package:http/http.dart' as http;

class AddImages {
  BaseUrl baseUrl = BaseUrl();

  Future<String> addImage(filepath, appUrl) async {
    Map<String, String> headers = {'Content-Type': 'multipart/form-data'};
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl.url + appUrl))
      // ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));

    print(request);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    return respStr;

    // return result['success:'];
  }
}
