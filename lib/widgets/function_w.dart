// ignore_for_file: must_be_immutable, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_note/widgets/derate.dart';

///这个组件用来重新加载整个child Widget的。当我们需要重启APP的时候，可以使用这个方案
///https://stackoverflow.com/questions/50115311/flutter-how-to-force-an-application-restart-in-production-mode
class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({Key? key, required this.child}) : super(key: key);

  static restartApp(BuildContext context) {
    final _RestartWidgetState? state =
        context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}

class ContentCard extends StatelessWidget {
  final String title;
  final String? content;
  final GestureTapCallback? tapFunc;

  ContentCard(
      {required this.title, required this.content, required this.tapFunc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bd1,
      child: Column(children: [
        Text(
          title,
          textAlign: TextAlign.start,
          textScaleFactor: 1.5,
        ),
        Html(
          data: _contentShrink(content!),
          shrinkWrap: true,
        )
      ]),
    );
  }

  final int indexMax = 50;

  _contentShrink(String content) {
    if (content.length < indexMax) {
      return content;
    } else {
      int index = indexMax - 1;
      while (content[index].isEmpty) {
        index++;
      }
      return content.substring(0, index);
    }
  }
}

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback? tapFunc;
  Decoration? decoration;
  EdgeInsets? padding;
  EdgeInsets? margin;

  MenuCard(
      {required this.icon,
      required this.text,
      required this.tapFunc,
      this.decoration,
      this.padding,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // ignore: sort_child_properties_last
      child: Container(
        // color: Colors.pink,
        // constraints: BoxConstraints(maxHeight: 200,maxWidth: 200),
        // padding: padding ??
        //     const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
        decoration: decoration,
        margin: margin ??
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: Colors.lightGreen),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 11),
            ),
          )
        ]),
      ),
      onTap: tapFunc,
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final RefreshCallback? onRefresh;

  LoadingOverlay(
      {required this.isLoading, required this.child, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    if (onRefresh == null) {
      return Stack(
        children: <Widget>[
          child,
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
    }
    return RefreshIndicator(
        onRefresh: onRefresh!,
        child: Stack(
          children: <Widget>[
            child,
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ));
  }
}
