import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/db/dbm.dart';
import 'package:flutter_note/common/db/objectbox.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/routes/add_note.dart';
import 'package:flutter_note/routes/home.dart';
import 'package:flutter_note/routes/meiying.dart';
import 'package:flutter_note/routes/meiying_detail.dart';
import 'package:flutter_note/routes/mine.dart';
import 'package:flutter_note/routes/momo.dart';
import 'package:flutter_note/routes/news_detail.dart';
import 'package:flutter_note/routes/note_detail.dart';
import 'package:flutter_note/routes/web.dart';
import 'package:flutter_note/widgets/function_w.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'routes/momo_detail.dart';

late ObjectBox objectBox;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  // DBM().initDB();
  WidgetsFlutterBinding.ensureInitialized;
  objectBox = await ObjectBox.create();
  if (Platform.isWindows) {
    final io.Directory cacheDir = await getApplicationDocumentsDirectory();
    String imageCachePath = p.join(cacheDir.path, "imageCache");
    await FastCachedImageConfig.init(
        subDir: imageCachePath, clearCacheAfter: const Duration(days: 15));
  }

  runApp(const NoteApp());
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
        child: MaterialApp(
      navigatorKey: navigatorKey,
      builder: FToastBuilder(),
      scrollBehavior: WindowsScrollBehavior(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        // 本地化的代理类
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
          primarySwatch: GlobalConfig.white, primaryColor: Colors.white
          // primarySwatch: Colors.lightGreen,
          ),
      // home: const HomeRoute(title: 'Home'),
      initialRoute: RouteNames.ALL_NOTE,
      routes: {
        RouteNames.ALL_NOTE: (context) => HomeRoute(),
        RouteNames.ADD_NOTE: (context) => AddNoteRoute(),
        RouteNames.NOTE_DETAIL: (context) => NoteDetailRoute(),
        RouteNames.NEWS_DETAIL: (context) => NewsDetailRoute(),
        RouteNames.MINE: (context) => MineRoute(),
        RouteNames.WEB: (context) => WebNoteRoute(),
        RouteNames.MOMO: (context) => MomoRoute(),
        RouteNames.MOMO_DETAIL: (context) => MomoDetailRoute(),
        RouteNames.MEIYING: (context) => MeiYingRoute(),
        RouteNames.MEIYING_DETAIL: (context) => MeiYingDetailRoute(),
      },
    ));
  }
}

class WindowsScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
