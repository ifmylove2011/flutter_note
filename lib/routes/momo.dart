import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/model/reptile/momo.dart';
import 'package:flutter_note/common/net/reptile_service.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/function_w.dart';

class MomoRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MomoRouteState();
  }
}

class _MomoRouteState extends State<MomoRoute> {
  List<Momo> momos = [];
  int page = 1;
  int detail_page = 1;
  bool loading = false;
  WebScraper webScraperMomo = WebScraper();

  @override
  void initState() {
    loading = true;
    requestMomo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MoMo图库'),
          // actions: const [
          //   IconButton(
          //       onPressed: _search,
          //       icon: Icon(Icons.search, color: Colors.lightGreen)),
          //   IconButton(
          //       onPressed: _moreDialog,
          //       icon: Icon(Icons.more_vert, color: Colors.lightGreen)),
          // ],
          // systemOverlayStyle: SystemUiOverlayStyle.light,
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
                    const Center(child: CircularProgressIndicator()),
                    Center(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: momos[index].postUrl!,
                      ),
                    )
                  ]),
                  Row(
                    children: [
                      Text(
                        style: const TextStyle(color: Colors.black54),
                        textAlign: TextAlign.start,
                        momos[index].dataPid!,
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
              // Navigator.pushNamed(context, RouteNames.NEWS_DETAIL,
              //         arguments: momos[index])
              //     .then((value) {
              //   debugPrint("--------$value");
              // });
              print(momos[index]);
            },
          )),
    );
  }

  void requestMomo() {
    Future(() async {
      setState(() {
        loading = true;
      });
      // return await webScraperMomo.loadFullURL('https://momotk.uno/');
      return await ReptileService.getMomoLocal();
    }).then((value) {
      List<Momo> temp = value!.reversed.toList();
      temp.addAll(momos);
      momos = temp;
      debugPrint("news.size=${momos.length}");
      setState(() {
        loading = false;
      });
    });
  }
}
