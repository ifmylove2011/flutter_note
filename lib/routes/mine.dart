import 'package:flutter/material.dart';
import 'package:flutter_note/generated/l10n.dart';

class MineRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MineRouteState();
  }

}

class MineRouteState extends State<MineRoute>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // body: _nestedBody(),
    );
  }
}

Widget _nestedBody(){
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
        body: Container(child: Text(S.current.settings)),
      );
}
