import 'package:flutter/material.dart';
import 'package:flutter_note/common/model/django/note.dart';
import 'package:flutter_note/common/net/note_service.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/main.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_note/widgets/joke_data.dart';
import 'package:flutter_note/widgets/new_data.dart';
import 'package:flutter_note/widgets/note_data.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  List<Note> notes = [];

  @override
  void initState() {
    requestNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(RouteNames.ALL_NOTE);
              },
            ),
            SizedBox(), //中间位置空出
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(RouteNames.MINE);
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: <Widget>[
      //     NoteList(),
      //     // NewsList(),
      //     // JokeList(),
      //   ],
      // ),
      body: _nestedBody1(),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        tooltip: 'add note',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void addNote() {
    Navigator.of(context).pushNamed(RouteNames.ADD_NOTE);
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
  }

  Widget _noteListView() {
    return ListView.separated(
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
                        arguments: notes[index]);
                  },
                )),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return d1;
        },
        itemCount: notes.length);
  }

  Widget _nestedBody() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          // 实现 snap 效果
          SliverAppBar(
            floating: true,
            snap: true,
            expandedHeight: 400,
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(S.current.home),
            ),
          ),
        ];
      },
      body: _noteListView(),
    );
  }

  Widget _nestedBody1() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        // 返回一个 Sliver 数组给外部可滚动组件。
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              floating: true,
              snap: true,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(S.current.home),
              ),
              forceElevated: innerBoxIsScrolled,
            ),
          ),
        ];
      },
      body: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            _noteListView(),
          ],
        );
      }),
    );
  }
}
