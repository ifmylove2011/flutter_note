import 'package:flutter/material.dart';

class Constant {
  static const HOME_IMG = "/images/panda1.jpeg";
  static const IS_MONSONRY = "is_monsonry";
  static const HOME_LAYOUT_STYLE = "home_layout_style";
}

class Global {
  static bool loading = true;
}

enum Layout {
  list,
  grid,
  monsonry,
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
