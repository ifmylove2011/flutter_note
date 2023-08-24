import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/django/django.dart';
import 'package:flutter_note/common/model/django/note.dart';
import 'package:flutter_note/common/net/dio_request.dart';
import 'package:flutter_note/common/net/http_origin.dart';

class NoteService {
  static getAllNote() async {
    // test();
    var res = await DioHolder.get()
        .dio
        .get('/noteservice', queryParameters: {"code": "C204"});
    print(res.toString());
    var result = JSON().fromJson(res.toString(), Django<List<Note>>)
        as Django<List<Note>>;
    return result.data;
  }
}
