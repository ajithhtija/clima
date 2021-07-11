import 'package:http/http.dart' as http;
import 'dart:convert';

class Networkhelper {

  Networkhelper(this.url);

  final String url;

  Future<dynamic> getdata() async
  {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    }
    else {
      print(response.statusCode);
    }
  }
}