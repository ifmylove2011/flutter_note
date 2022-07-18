import 'package:flutter/material.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/widgets/new_data.dart';
import 'package:flutter_note/widgets/note_data.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.subTitle),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.list_alt),
              onPressed: () {},
            ),
            SizedBox(), //中间位置空出
            IconButton(
              icon: Icon(Icons.class_),
              onPressed: () {},
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // NoteList(),
            NewsList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        tooltip: 'add note',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void addNote() {}
}
