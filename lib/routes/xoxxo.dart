import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/model/reptile/xoxo.dart';
import 'package:flutter_note/common/net/reptile_service.dart';
import 'package:flutter_note/main.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../generated/l10n.dart';
import '../widgets/function_w.dart';

class XoxoRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _XoxoRouteState();
  }
}

class _XoxoRouteState extends State<XoxoRoute> {
  late ScrollController _scrollController;
  final xoxoBox = objectBox.store.box<Xoxo>();
  List<Xoxo> xoxos = [];
  int page = 1;
  bool loading = false;

  @override
  void initState() {
    loading = true;
    requestXoxo();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter == 0) {
        _loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: nestedBody());
  }

  Widget nestedBody() {
    return NestedScrollView(
      // controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              titleSpacing: 0,
              leading: Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.lightGreen), //自定义图标
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              }),
              title: Text(S.current.xoxo),
              pinned: false,
              snap: true,
              floating: true,
            ),
          ),
        ];
      },
      body: Builder(builder: (BuildContext context) {
        return _body(context);
      }),
    );
  }

  Widget _body(BuildContext context) {
    if (Platform.isAndroid) {
      //处理因SliveApp存在ListView或GridView无法感知头部高度的问题
      return LoadingOverlay(
          onRefresh: _loadMore,
          isLoading: loading,
          child: CustomScrollView(
            controller: _scrollController,
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
                    childCount: xoxos.length,
                  ),
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  )),
            ],
          ));
    }
    return LoadingOverlay(
      onRefresh: _loadMore,
      isLoading: loading,
      child: MasonryGridView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
        itemCount: xoxos.length,
      ),
    );
  }

  Future _loadMore() async {
    print("loading more ...");
    page++;
    requestXoxo();
  }

  Widget _item(int index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: DecoratedBox(
          decoration: bd1,
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 11),
                    textAlign: TextAlign.start,
                    xoxos[index].title!,
                  ),
                  Stack(children: <Widget>[
                    const Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    ),
                    FastCachedImage(
                      url: xoxos[index].postUrl!,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(seconds: 1),
                      errorBuilder: (context, exception, stacktrace) {
                        return Text(stacktrace.toString());
                      },
                      // loadingBuilder: (context, progress) {
                      //   return Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       if (progress.isDownloading &&
                      //           progress.totalBytes != null)
                      //         Text(
                      //             '${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes! ~/ 1024} kb',
                      //             style: const TextStyle(color: Colors.red)),
                      //       Center(
                      //           child: CircularProgressIndicator(
                      //               color: Colors.red,
                      //               value: progress.progressPercentage.value)),
                      //     ],
                      //   );
                      // },
                    )
                    // FadeInImage.memoryNetwork(
                    //   placeholder: kTransparentImage,
                    //   image: momos[index].postUrl!,
                    // ),
                  ])
                ],
              ),
            ),
            onTap: () {
              print(xoxos[index]);
              Navigator.pushNamed(context, RouteNames.XOXO_DETAIL,
                  arguments: xoxos[index]);
            },
          )),
    );
  }

  void requestXoxo() {
    Future(() async {
      setState(() {
        loading = true;
      });
      return await ReptileService().getXoxo(page);
      // return await ReptileService().getMeiYingLocal();
    }).then((value) {
      List<Xoxo> temp = value!.toList();
      temp.addAll(xoxos);
      xoxos = temp.toSet().toList();
      xoxos.sort((a, b) => b.id!.compareTo(a.id!));
      // print(meiyings.toString());
      debugPrint("xoxos.size=${xoxos.length}");
      setState(() {
        loading = false;
      });
    });
  }
}
