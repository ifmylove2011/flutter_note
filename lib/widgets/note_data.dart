import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/model/note.dart';
import 'package:flutter_note/widgets/derate.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  List<Note> notes = [];
  List<String> words = [];
  @override
  void initState() {
    super.initState();
    requestNote();
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
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: Text(
                        words[index],
                        textScaleFactor: 2,
                      ),
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return d1;
            },
            itemCount: words.length));
  }

  void requestNote() async {
    // Future(() {
    //   //TODO 请求
    // })
    //     .then((value) {
    //   //TODO 赋值
    // });
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        words.insertAll(
          0,
          generateWordPairs().take(10).map((e) => e.asPascalCase).toList(),
        );
      });
    });
  }
}
