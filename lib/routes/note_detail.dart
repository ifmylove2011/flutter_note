import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_note/common/model/django/note.dart';

class NoteDetailRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteDetailRouteState();
  }
}

class _NoteDetailRouteState extends State<NoteDetailRoute> {
  @override
  Widget build(BuildContext context) {
    var note = ModalRoute.of(context)?.settings.arguments as Note;
    print(note.content);

    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: const [
          // IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.attach_file,
          //       color: Colors.lightGreen,
          //     )),
          IconButton(
              onPressed: _changeFont,
              icon: Icon(Icons.font_download, color: Colors.lightGreen)),
          IconButton(
              onPressed: _shareNoteSingle,
              icon: Icon(Icons.share, color: Colors.lightGreen)),
          IconButton(
              onPressed: _moreDialog,
              icon:  Icon(Icons.more_vert, color: Colors.lightGreen)),
        ],
        // systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: Builder(builder: (context) {
          return IconButton(
            icon:
                const Icon(Icons.arrow_back, color: Colors.lightGreen), //自定义图标
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Html(
          data: note.content,
        ),
      )),
    );
  }
}

_moreDialog(){

}

_shareNoteSingle(){

}

_changeFont(){

}