import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/model/reptile/mei_ying.dart';
import 'package:flutter_note/common/model/reptile/momo.dart';
import 'package:flutter_note/common/model/reptile/momo_detail.dart';
import 'package:flutter_note/common/net/reptile_service.dart';
import 'package:flutter_note/main.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:objectbox/objectbox.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../common/db/objectbox.dart';
import '../generated/l10n.dart';
import '../widgets/function_w.dart';

class MeiYingRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MeiYingRouteState();
  }
}

class _MeiYingRouteState extends State<MeiYingRoute> {
  late ScrollController _scrollController;
  final meiyingBox = objectBox.store.box<MeiYing>();
  List<MeiYing> meiyings = [];
  int page = 1;
  bool loading = false;
  WebScraper webScraperMomo = WebScraper();
  // final database = Provider.of<AppDatabase>(context);

  @override
  void initState() {
    loading = true;
    requestMeiying();
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
      controller: _scrollController,
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
              title: Text(S.current.meiying),
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
                    childCount: meiyings.length,
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
        shrinkWrap: true,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
        itemCount: meiyings.length,
      ),
    );
  }

  Future _loadMore() async {
    print("loading more ...");
    page++;
    requestMeiying();
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
                    meiyings[index].title!,
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
                      url: meiyings[index].postUrl!,
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
                  ]),
                  Row(
                    children: [
                      Text(
                        style: const TextStyle(color: Colors.black54),
                        textAlign: TextAlign.start,
                        meiyings[index].author.toString(),
                        textScaleFactor: 0.8,
                      ),
                      const Spacer(),
                      Text(
                        style: const TextStyle(color: Colors.black54),
                        textAlign: TextAlign.end,
                        meiyings[index].descNum!,
                        textScaleFactor: 0.8,
                      ),
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              print(meiyings[index]);
              Navigator.pushNamed(context, RouteNames.MEIYING_DETAIL,
                  arguments: meiyings[index]);
            },
          )),
    );
  }

  void requestMeiying() {
    Future(() async {
      setState(() {
        loading = true;
      });
      return await ReptileService().getMeiying(page);
      // return await ReptileService().getMeiYingLocal();
    }).then((value) {
      List<MeiYing> temp = value!.toList();
      temp.addAll(meiyings);
      meiyings = temp.toSet().toList();
      meiyings.sort((a, b) => b.id!.compareTo(a.id!));
      // print(meiyings.toString());
      debugPrint("meiyings.size=${meiyings.length}");
      setState(() {
        loading = false;
      });
    });
  }
}
