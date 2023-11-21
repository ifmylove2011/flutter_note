import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:web_scraper/web_scraper.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  test('http test', () async {
    var client = Client();

    var _response = await client.get(Uri.parse('https://momotk.uno/'));
    // Calculating Time Elapsed using timer from dart:core.
    // Parses the response body once it's retrieved to be used on the other methods.
    // _document = parse(_response.body);
    expect(_response.body, isNotEmpty);
    print(_response.body);
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
