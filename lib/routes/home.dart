import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/model/arguments/notes_index.dart';
import 'package:flutter_note/common/model/django/note.dart';
import 'package:flutter_note/common/net/note_service.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/main.dart';
import 'package:flutter_note/widgets/bubble.dart';
import 'package:flutter_note/widgets/bulletin_data.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_note/widgets/function_w.dart';
import 'package:flutter_note/widgets/grid_menu.dart';
import 'package:flutter_note/widgets/joke_data.dart';
import 'package:flutter_note/widgets/new_data.dart';
import 'package:flutter_note/widgets/note_data.dart';
import 'package:flutter_note/widgets/popup.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  List<Note> notes = [];
  bool isMonsonry = false;

  final ScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // requestNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.lightGreen),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(RouteNames.ALL_NOTE);
              },
            ),
            // SizedBox(), //中间位置空出
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.lightGreen,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteNames.MINE);
              },
            ),
          ], //均分底部导航栏横向空间
        ),
      ),
      body: BulletinList(),
      // body: _nestedBody(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        hoverColor: Colors.green,
        backgroundColor: Colors.lightGreen,
        onPressed: showbottom,
        tooltip: 'add note',
        child: const Icon(
          Icons.add,
        ),
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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    print("screen w=$width,h=$height");
    Navigator.of(context).push(PopupFreeWindow(
      // widthFactor: 0.95,
      // heightFactor: 0.4,
      height: 200,
      width: width - 30,
      child: ChatBubble(
        direction: ArrowDirection.bottom,
        arrowWidth: 30,
        arrowHeight: 20,
        conicWeight: 4.5,
        child: GridMenu(),
      ),
    ));
  }

  Widget _swiper() {
    return Swiper(
      indicatorAlignment: AlignmentDirectional.bottomCenter,
      speed: 400,
      autoStart: false,
      controller: SwiperController(initialPage: 1),
      viewportFraction: 1.0,
      indicator: CircleSwiperIndicator(),
      onChanged: (index) => debugPrint('$index'),
      children: List.generate(10, (index) => index)
          .map((e) => Text(e.toString() + "------"))
          .toList(),
    );
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

  Widget _noteMasonryView() {
    return SingleChildScrollView(
      child: MasonryGridView.count(
        // 展示几列
        crossAxisCount: 3,
        // 元素总个数
        itemCount: notes.length,
        // 单个子元素
        itemBuilder: (BuildContext context, int index) => ContentCard(
            title: notes[index].title,
            content: notes[index].content,
            tapFunc: () {}),
        // 纵向元素间距
        mainAxisSpacing: 10,
        // 横向元素间距
        crossAxisSpacing: 10,
        //本身不滚动，让外面的singlescrollview来滚动
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true, //收缩，让元素宽度自适应
      ),
    );
  }

  Widget _noteListView() {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              child: Container(
                decoration: bd1,
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: Text(
                  notes[index].title,
                  textScaleFactor: 1.5,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, RouteNames.NOTE_DETAIL,
                        arguments: NotesAndIndex(notes: notes, index: index))
                    .then((value) {
                  print("index=$value");
                });
              },
            ),
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
                  onPressed: _switchView,
                  icon: Icon(isMonsonry ? Icons.grid_on : Icons.list,
                      color: Colors.lightGreen)),
              IconButton(
                  onPressed: _moreDialog,
                  icon: const Icon(Icons.more_vert, color: Colors.lightGreen)),
            ],
            // expandedHeight: 150,
            // flexibleSpace: FlexibleSpaceBar(
            //   collapseMode: CollapseMode.pin,
            //   background: _topBars(),
            // ),
          ),
        ];
      },
      body: isMonsonry ? _noteMasonryView() : _noteListView(),
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

  void _switchView() {
    isMonsonry = !isMonsonry;
    setState(() {});
  }

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
        MenuCard(
            icon: Icons.article,
            text: S.current.literal_note,
            tapFunc: _addNote),
        MenuCard(
            icon: Icons.audio_file,
            text: S.current.audio_note,
            tapFunc: _addNote),
      ],
    );
  }
}
