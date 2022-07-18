import 'package:flutter/cupertino.dart';
import 'package:flutter_note/widgets/note_data.dart';

class NoteRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteRouteState();
  }
}

class _NoteRouteState extends State<NoteRoute> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: NoteList(),
    );
  }
}
