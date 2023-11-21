import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/model/juhe/bulletin.dart';
import 'package:flutter_note/common/net/juhe_service.dart';
import 'package:flutter_note/common/util/str_util.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_note/widgets/function_w.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BulletinList extends StatefulWidget {
  const BulletinList({Key? key, required this.layout}) : super(key: key);

  final Layout layout;

  @override
  State<StatefulWidget> createState() {
    return _BulletinListState();
  }
}

class _BulletinListState extends State<BulletinList> {
  List<Bulletin> bulletins = [];
  bool loading = true;

  @override
  void initState() {
    requestBulletin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.layout == Layout.grid || widget.layout == Layout.monsonry) {
      //   return LoadingOverlay(
      //       isLoading: loading,
      //       child: GridView.builder(
      //           shrinkWrap: true,
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               mainAxisSpacing: 10,
      //               crossAxisSpacing: 5,
      //               crossAxisCount: 2,
      //               childAspectRatio: 2),
      //           itemBuilder: _itemBuilder));
      // } else if (widget.layout == Layout.monsonry) {
      if (Platform.isAndroid) {
        //处理因SliveApp存在ListView或GridView无法感知头部高度的问题
        return LoadingOverlay(
            isLoading: loading,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverMasonryGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: bulletins.length,
                      (context, index) {
                        return _item(index);
                      },
                    ),
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    )),
              ],
            ));
      }
      return LoadingOverlay(
        isLoading: loading,
        child: MasonryGridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          },
          itemCount: bulletins.length,
        ),
      );
    } else {
      if (Platform.isAndroid) {
        //处理因SliveApp存在ListView或GridView无法感知头部高度的问题
        return LoadingOverlay(
            isLoading: loading,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _item(index);
                  },
                  childCount: bulletins.length,
                ))
              ],
            ));
      }
      return LoadingOverlay(
          isLoading: loading,
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return _item(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return d1;
              },
              itemCount: bulletins.length));
    }
  }

  Widget _item(int index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: DecoratedBox(
          decoration: bd1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.start,
                  bulletins[index].title!.trimLeft(),
                  textScaleFactor: 1.5,
                ),
                Text(
                  textAlign: TextAlign.start,
                  StrUtil.trimAbstract(bulletins[index].digest!),
                  textScaleFactor: 1,
                ),
                Text(
                  style: const TextStyle(color: Colors.black54),
                  textAlign: TextAlign.start,
                  bulletins[index].mtime!,
                  textScaleFactor: 0.8,
                )
              ],
            ),
          )),
    );
  }

  void requestBulletin() async {
    Future(() async {
      setState(() {
        loading = true;
      });
      // return await JuheService.getBulletins();
      return await JuheService.getBulletinsLocal();
    }).then((value) {
      bulletins = value!;
      setState(() {
        loading = false;
      });
    });
  }
}
