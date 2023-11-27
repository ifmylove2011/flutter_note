import 'dart:async';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/routes/momo.dart';
import 'package:flutter_note/widgets/bubble.dart';
import 'package:flutter_note/widgets/bulletin_data.dart';
import 'package:flutter_note/widgets/function_w.dart';
import 'package:flutter_note/widgets/grid_menu.dart';
import 'package:flutter_note/widgets/joke_data.dart';
import 'package:flutter_note/widgets/new_data.dart';
import 'package:flutter_note/widgets/note_data.dart';
import 'package:flutter_note/widgets/popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int layoutStyle = Layout.list.index;

  // final ScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future(() async {
      return await SharedPreferences.getInstance();
    }).then((prefs) {
      layoutStyle =
          prefs.getInt(Constant.HOME_LAYOUT_STYLE) ?? Layout.list.index;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: ScaffoldKey,
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
      body: nestedBody(),
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

  Widget nestedBody() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: Text(S.current.all_content),
              pinned: false,
              snap: true,
              floating: true,
              actions: [
                IconButton(
                    onPressed: _switchLayoutGrid,
                    icon: Icon(
                        layoutStyle == Layout.list.index
                            ? Icons.list
                            : Icons.grid_on,
                        color: Colors.lightGreen)),
                _moreDialog(context),
              ],
            ),
          ),
        ];
      },
      body: Builder(builder: (BuildContext context) {
        return NewsList(layout: Layout.values[layoutStyle]);
      }),
    );
  }

  void addNote() {
    Navigator.of(context).pushNamed(RouteNames.ADD_NOTE);
  }

  PopupMenuButton _moreDialog(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: Text(S.current.momo),
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.MOMO);
              },
            ),
            PopupMenuItem(
              child: Text(S.current.meiying),
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.MEIYING);
              },
            ),
            PopupMenuItem(
              child: Text(S.current.xoxo),
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.XOXO);
              },
            ),
          ];
        },
        onSelected: (value) {
          print(value);
        },
        onCanceled: () {
          print("canceled");
        },
        icon: const Icon(Icons.more_horiz, color: Colors.lightGreen));
  }

  /// 切换列表/方格/瀑布视图
  void _switchLayoutGrid() {
    if (layoutStyle == Layout.list.index) {
      layoutStyle = Layout.monsonry.index;
    } else if (layoutStyle == Layout.monsonry.index) {
      layoutStyle = Layout.list.index;
    }
    Future(() async {
      return await SharedPreferences.getInstance();
    }).then((prefs) {
      prefs.setInt(Constant.HOME_LAYOUT_STYLE, layoutStyle);
    });
    debugPrint("layoutStyle=$layoutStyle");
    setState(() {});
  }

  Widget _topBars() {
    return ListView(
      // shrinkWrap: true,
      padding:
          const EdgeInsets.only(top: kToolbarHeight, left: 20.0, right: 20.0),
      scrollDirection: Axis.horizontal,
      children: [
        MenuCard(
            icon: Icons.article,
            text: S.current.literal_note,
            tapFunc: addNote),
        MenuCard(
            icon: Icons.audio_file,
            text: S.current.audio_note,
            tapFunc: addNote),
      ],
    );
  }

  void showbottom() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    debugPrint("screen w=$width,h=$height");
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
          .map((e) => Text("$e------"))
          .toList(),
    );
  }

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
}
