import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebNoteRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebNoteRouteState();
  }
}

class _WebNoteRouteState extends State<WebNoteRoute> {
  WebViewController getController(String url) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter WebView 示例'),
        ),
        body: WebViewWidget(
          controller: getController("https://momotk.uno/"),
        ));
  }
}
