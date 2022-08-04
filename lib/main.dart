import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/routes/add_note.dart';
import 'package:flutter_note/routes/home.dart';
import 'package:flutter_note/routes/mine.dart';
import 'package:flutter_note/routes/note_detail.dart';
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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        // 本地化的代理类
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: "Flutter Note",
      theme: ThemeData(
          primarySwatch: GlobalConfig.white, primaryColor: Colors.white
          // primarySwatch: Colors.lightGreen,
          ),
      // home: const HomeRoute(title: 'Home'),
      initialRoute: RouteNames.ALL_NOTE,
      routes: {
        RouteNames.ALL_NOTE: (context) => HomeRoute(title: 'Home'),
        RouteNames.ADD_NOTE: (context) => AddNoteRoute(),
        RouteNames.NOTE_DETAIL: (context) => NoteDetailRoute(),
        RouteNames.MINE: (context) => MineRoute(),
      },
    ));
  }
}

class GlobalConfig {
  static const int _primaryColorValue = 0xFFFFFFFF;
  static const Color primaryColor = Color(_primaryColorValue);
  static const MaterialColor primarySwatchColor = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      50: Color(0xFFD1E3F6),
      100: Color(0xFFA7C9ED),
      200: Color(0xFF7EB0E4),
      300: Color(0xFF5999DB),
      400: Color(0xFF3683D2),
      500: Color(_primaryColorValue),
      600: Color(0xFF1258A1),
      700: Color(0xFF0d4279),
      800: Color(0xFF092C50),
      900: Color(0xFF041628),
    },
  );

  static const MaterialColor white = MaterialColor(
    _whitePrimaryValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFEFEFE),
      200: Color(0xFFFDFDFD),
      300: Color(0xFFFCFCFC),
      400: Color(0xFFFBFBFB),
      500: Color(_whitePrimaryValue),
      600: Color(0xFFF0F0F0),
      700: Color(0xFFEFEFEF),
      800: Color(0xFFEEEEEE),
      900: Color(0xFFEAEAEA),
    },
  );
  static const int _whitePrimaryValue = 0xFFFAFAFA;
}

class RouteNames {
  static const ALL_NOTE = "all_note";
  static const ADD_NOTE = "add_note";
  static const NOTE_DETAIL = "note_detail";
  static const MINE = "mine";
}
