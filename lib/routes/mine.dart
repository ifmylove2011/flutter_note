import 'package:flutter/material.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/widgets/derate.dart';

class MineRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MineRouteState();
  }
}

class MineRouteState extends State<MineRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _nestedBody(),
    );
  }
}

Widget _nestedBody() {
  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        // 实现 snap 效果
        SliverAppBar(
          floating: true,
          snap: true,
          expandedHeight: 200,
          forceElevated: innerBoxIsScrolled,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "/images/panda2.jpeg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ];
    },
    // body: Builder(builder: (BuildContext context) {
    //   return CustomScrollView(

    //     slivers: <Widget>[
    //       Text(S.current.settings),
    //     ],
    //   );
    // }),
    body: Container(
        child: Column(
      children: [
        buildMenuItem(S.current.alarm),
        buildMenuItem(S.current.settings),
        buildMenuItem(S.current.about),
      ],
    )),
  );
}

Widget buildMenuItem(String text) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: bd3,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
        Icon(
          Icons.arrow_forward_ios,
        )
      ],
    ),
  );
}
