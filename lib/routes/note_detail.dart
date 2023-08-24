import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_note/common/model/arguments/notes_index.dart';
import 'package:flutter_note/common/model/django/note.dart';

class NoteDetailRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteDetailRouteState();
  }
}

class _NoteDetailRouteState extends State<NoteDetailRoute> {
  late PageController pc;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments as NotesAndIndex;
    var note = data.notes[data.index];
    currentIndex = data.index;
    print(data.index);

    return Scaffold(
      appBar: AppBar(
        // title: Text(note.title),
        actions: const [
          IconButton(
              onPressed: _changeFont,
              icon: Icon(Icons.font_download, color: Colors.lightGreen)),
          IconButton(
              onPressed: _shareNoteSingle,
              icon: Icon(Icons.share, color: Colors.lightGreen)),
          IconButton(
              onPressed: _moreDialog,
              icon: Icon(Icons.more_vert, color: Colors.lightGreen)),
        ],
        // systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: Builder(builder: (context) {
          return IconButton(
            icon:
                const Icon(Icons.arrow_back, color: Colors.lightGreen), //自定义图标
            onPressed: () {
              Navigator.of(context).pop(currentIndex);
            },
          );
        }),
      ),
      body: PageView.builder(
          physics: const PageScrollPhysics(),
          controller: PageController(initialPage: data.index, keepPage: false),
          scrollDirection: Axis.vertical,
          itemCount: data.notes.length,
          onPageChanged: (int index) {
            print(index);
            currentIndex = index;
          },
          itemBuilder: (BuildContext bc, int index) {
            return Container(
                child: Column(
              children: [
                Text(
                  data.notes[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SingleChildScrollView(
                  child: Html(
                    data: data.notes[index].content,
                  ),
                )
              ],
            ));
          }),
    );
  }
}

_moreDialog() {}

_shareNoteSingle() {}

_changeFont() {}
