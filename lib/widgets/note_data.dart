import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/django/django.dart';
import 'package:flutter_note/common/model/django/note.dart';
import 'package:flutter_note/common/net/dio_request.dart';
import 'package:flutter_note/common/net/note_service.dart';
import 'package:flutter_note/main.dart';
import 'package:flutter_note/routes/note_detail.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  List<Note> notes = [];
  int currentIndex = 0;

  @override
  void initState() {
    requestNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: DecoratedBox(
                    decoration: bd1,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: Text(
                          notes[index].title,
                          textScaleFactor: 1.5,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.NOTE_DETAIL,
                                arguments: notes[index])
                            .then((value) {
                          print("--------$value");
                        });
                      },
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return d1;
            },
            itemCount: notes.length));
  }

  void requestNote() {
    Future(() async {
      //TODO 请求
      return await NoteService.getAllNote();
    }).then((value) {
      //TODO 赋值
      notes = value!;
      setState(() {});
    }).catchError((error) {
      print(error);
    });
    // Future.delayed(Duration(seconds: 1)).then((value) {
    //   setState(() {
    //     words.insertAll(
    //       0,
    //       generateWordPairs().take(10).map((e) => e.asPascalCase).toList(),
    //     );
    //   });
    // });
  }
}
