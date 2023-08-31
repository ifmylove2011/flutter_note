import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_note/common/constant.dart';
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
