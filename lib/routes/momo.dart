import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
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
import '../widgets/function_w.dart';

class MomoRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MomoRouteState();
  }
}

class _MomoRouteState extends State<MomoRoute> {
  late ScrollController _scrollController;
  final momoBox = objectBox.store.box<Momo>();
  List<Momo> momos = [];
  List<MomoDetail> momoDetails = [];
  int page = 1;
  bool loading = false;
  WebScraper webScraperMomo = WebScraper();
  // final database = Provider.of<AppDatabase>(context);

  @override
  void initState() {
    loading = true;
    requestMomo();
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
    return Scaffold(
        appBar: AppBar(
          title: Text('MoMo图库'),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.lightGreen), //自定义图标
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }),
        ),
        body: _body());
  }

  Widget _body() {
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
                    childCount: momos.length,
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
        itemCount: momos.length,
      ),
    );
  }

  Future _loadMore() async {
    print("loading more ...");
    page++;
    requestMomo();
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
                    momos[index].title!,
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
                      url: momos[index].postUrl!,
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
                        momos[index].dataPid.toString(),
                        textScaleFactor: 0.8,
                      ),
                      const Spacer(),
                      Text(
                        style: const TextStyle(color: Colors.black54),
                        textAlign: TextAlign.end,
                        momos[index].descNum!,
                        textScaleFactor: 0.8,
                      ),
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              print(momos[index]);
              Navigator.pushNamed(context, RouteNames.MOMO_DETAIL,
                  arguments: momos[index]);
            },
          )),
    );
  }

  void requestMomo() {
    Future(() async {
      setState(() {
        loading = true;
      });
      // List<Momo> momos = await momoBox.getAllAsync();
      // debugPrint("in db momo.size=${momos.length}");
      // return await webScraperMomo.loadFullURL('https://momotk.uno/');
      return await ReptileService().getMomo(page);
    }).then((value) {
      List<Momo> temp = value!.toList();
      temp.addAll(momos);
      momos = temp.toSet().toList();
      momos.sort((a, b) => b.dataPid!.compareTo(a.dataPid!));
      debugPrint("momo.size=${momos.length}");
      setState(() {
        loading = false;
      });
    });
  }
}
