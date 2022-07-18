import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/routes/home.dart';
import 'package:flutter_note/widgets/function_w.dart';

void main() {
  runApp(const NoteApp());
  // if (Platform.isAndroid) {
  //   //设置Android头部的导航栏透明
  //   SystemUiOverlayStyle systemUiOverlayStyle =
  //       SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // }
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
        child: MaterialApp(
      localizationsDelegates: const [
        // 本地化的代理类
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: "Flutter Note",
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: const HomeRoute(title: 'Home'),
    ));
  }
}
