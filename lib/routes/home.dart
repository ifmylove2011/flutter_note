import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/model/django/note.dart';
import 'package:flutter_note/common/net/note_service.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/main.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_note/widgets/joke_data.dart';
import 'package:flutter_note/widgets/new_data.dart';
import 'package:flutter_note/widgets/note_data.dart';
import 'package:flutter_note/widgets/popup.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  List<Note> notes = [];
  final ScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    requestNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.lightGreen),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(RouteNames.ALL_NOTE);
              },
            ),
            SizedBox(), //中间位置空出
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.lightGreen,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteNames.MINE);
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
      body: _nestedBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: showbottom,
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

  void showbottom() {
    // Navigator.of(context).push(PopBottomMenu(
    //     child: Container(
    //   // alignment: Alignment.center,
    //   constraints: BoxConstraints(maxWidth: 300, maxHeight: 150),
    //   margin: EdgeInsets.only(bottom: kToolbarHeight * 1.5),
    //   // decoration: bd1,
    //   child: _topBars(),
    // )));
    Navigator.of(context).push(PopBottomMenu(
        child: SizedBox(
      child: Container(
        color:Colors.white,
        child: Swiper(
        indicatorAlignment: AlignmentDirectional.bottomCenter,
        speed: 400,
        controller: SwiperController(initialPage: 1),
        viewportFraction: 1.0,
        indicator: RectangleSwiperIndicator(),
        onChanged: (index) => debugPrint('$index'),
        children: List.generate(10, (index) => index)
            .map((e) => Text(e.toString()+"------"))
            .toList(),
      )),
      width: 300,
      height: 150,
    )));
  }

  void showNNpop() {
    Navigator.of(context).push(NNPopupRoute(
        alignment: Alignment.bottomCenter,
        onClick: () {},
        child: Container(
          // alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 300, maxHeight: 150),
          margin: EdgeInsets.only(bottom: kToolbarHeight * 1.5),
          decoration: bd1,
          child: _topBars(),
        )));
  }

  //TODO 后续看看是否能实现气泡式菜单
  void showPopup() {
    showModalBottomSheet(
        context: context,
        // useRootNavigator: true,
        constraints: BoxConstraints(maxHeight: 200, minWidth: 800),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        builder: (BuildContext context) {
          return Container(
            child: Column(
              children: [
                ElevatedButton(onPressed: () {}, child: Text("1")),
                ElevatedButton(onPressed: () {}, child: Text("2")),
              ],
            ),
          );
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
            title: Text(S.current.all_note),
            pinned: true,
            stretch: true,
            floating: true,
            snap: true,
            actions: [
              IconButton(
                  onPressed: _sort,
                  icon: Icon(Icons.sort, color: Colors.lightGreen)),
              IconButton(
                  onPressed: _moreDialog,
                  icon: Icon(Icons.more_vert, color: Colors.lightGreen)),
            ],
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: _topBars(),
            ),
          ),
        ];
      },
      body: _noteListView(),
    );
  }

  @Deprecated("wait for modify")
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

  void _moreDialog() {}

  void _sort() {}

  void _addNote() {
    print("wait for ...");
  }

  _topBars() {
    return ListView(
      // shrinkWrap: true,
      padding:
          const EdgeInsets.only(top: kToolbarHeight, left: 20.0, right: 20.0),
      scrollDirection: Axis.horizontal,
      children: [
        card(Icons.article, S.current.literal_note, _addNote),
        card(Icons.audio_file, S.current.audio_note, _addNote),
      ],
    );
  }
}
