import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/model/juhe/news.dart';
import 'package:flutter_note/common/net/juhe_service.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_note/widgets/function_w.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key, required this.layout}) : super(key: key);

  final Layout layout;

  @override
  State<StatefulWidget> createState() {
    return _NewsListState();
  }
}

class _NewsListState extends State<NewsList> {
  List<News> news = [];
  int page = 1;
  bool loading = false;

  @override
  void initState() {
    loading = true;
    requestNews();
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
                SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _item(index);
                  },
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
              itemCount: news.length));
    }
  }

  Future _loadMore() async {
    page++;
    requestNews();
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
                      fontWeight: FontWeight.bold, fontSize: 13),
                  textAlign: TextAlign.start,
                  news[index].title,
                  textScaleFactor: 1.5,
                ),
                Text(
                  textAlign: TextAlign.start,
                  news[index].url!,
                  textScaleFactor: 1,
                ),
                Text(
                  style: const TextStyle(color: Colors.black54),
                  textAlign: TextAlign.start,
                  news[index].date!,
                  textScaleFactor: 0.8,
                )
              ],
            ),
          )),
    );
  }

  void requestNews() {
    Future(() async {
      setState(() {
        loading = true;
      });
      return await JuheService.getNewsLocal();
    }).then((value) {
      List<News> temp = value!.reversed;
      temp.addAll(news);
      news = temp;
      debugPrint("news.size=${news.length}");
      setState(() {
        loading = false;
      });
    });
  }
}
