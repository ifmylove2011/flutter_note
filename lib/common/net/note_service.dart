import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/django/django.dart';
import 'package:flutter_note/common/model/django/note.dart';
import 'package:flutter_note/common/net/dio_request.dart';

class NoteService {
  static getAllNote() async {
    var res = await DioHolder.get()
        .dio
        .get('/noteservice', queryParameters: {"code": "C204"});
    var result = JSON().fromJson(res.toString(), Django<List<Note>>)
        as Django<List<Note>>;
    debugPrint("note.size=${result.data?.length}");
    return result.data;
  }

  static getAllNoteLocal() async {
    var res = await rootBundle.loadString("assets/data/notes.json");
    var result = JSON().fromJson(res.toString(), Django<List<Note>>)
        as Django<List<Note>>;
    return result.data;
  }
}
