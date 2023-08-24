import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<void> test() async {
  var httpClient = new HttpClient();
  var uri = new Uri.http(
      "http://192.168.21.202:5055", '/noteservice', {"code": "C204"});
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  print(response.statusCode);
  var responseBody = await response.transform(utf8.decoder).join();
}

Future<void> testBulletin() async {
  var httpClient = new HttpClient();
  var uri = new Uri.http("http://apis.juhe.cn", '/fapigx/bulletin/query',
      {"key": "2ec96a8869a74b64cf6bc00f9d6b8414"});
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  print(response.statusCode);
  var responseBody = await response.transform(utf8.decoder).join();
}
