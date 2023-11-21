// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_note/common/model/juhe/news.dart';
import 'package:flutter_note/common/net/juhe_service.dart';
import 'package:flutter_note/common/util/str_util.dart';
import 'package:flutter_note/widgets/function_w.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsDetailState();
  }
}

class _NewsDetailState extends State<NewsDetailRoute> {
  bool loading = false;
  late News news;
  String content = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("--------building");
    news = ModalRoute.of(context)?.settings.arguments as News;

    // if (StrUtil.isEmpty(content) && !loading) {
    //   requestNewsUrl();
    // }

    return Scaffold(
        appBar: AppBar(
          // title: Text(note.title),
          actions: const [
            IconButton(
                onPressed: _search,
                icon: Icon(Icons.search, color: Colors.lightGreen)),
            IconButton(
                onPressed: _moreDialog,
                icon: Icon(Icons.more_vert, color: Colors.lightGreen)),
          ],
          // systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.lightGreen), //自定义图标
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }),
        ),
        body: Platform.isAndroid || Platform.isIOS
            ? WebViewWidget(
                controller: getController(news.url!),
              )
            : getHtml());
  }

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

  Widget getHtml() {
    // return SingleChildScrollView(
    //   child: Html(data: content),
    // );
    // return WebViewWidget(controller: _controller);
    return SingleChildScrollView(
      child: HtmlWidget(
        // the first parameter (`html`) is required
        content,
        // all other parameters are optional, a few notable params:

        // specify custom styling for an element
        // see supported inline styling below
        customStylesBuilder: (element) {
          if (element.classes.contains('foo')) {
            return {'color': 'red'};
          }

          return null;
        },
        buildAsync: true,
        // render a custom widget
        customWidgetBuilder: (element) {
          return null;
        },

        // these callbacks are called when a complicated element is loading
        // or failed to render allowing the app to render progress indicator
        // and fallback widget
        onErrorBuilder: (context, element, error) =>
            Text('$element error: $error'),
        onLoadingBuilder: (context, element, loadingProgress) =>
            const CircularProgressIndicator(),

        // this callback will be triggered when user taps a link
        onTapUrl: (url) {
          debugPrint("onTap=$url");
          return false;
        },

        // select the render mode for HTML body
        // by default, a simple `Column` is rendered
        // consider using `ListView` or `SliverList` for better performance
        renderMode: RenderMode.column,

        // set the default styling for text
        textStyle: TextStyle(fontSize: 14),
      ),
    );
  }

  void requestNewsUrl() {
    Future(() async {
      setState(() {
        loading = true;
      });
      return await JuheService.getNewsUrl(news.url!);
    }).then((value) {
      content = value!;
      setState(() {
        loading = false;
      });
    });
  }
}

void _search() {}

void _moreDialog() {}
