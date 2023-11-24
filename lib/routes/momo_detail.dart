import 'dart:io';

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

class MomoDetailRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MomoDetailRouteState();
  }
}

class _MomoDetailRouteState extends State<MomoDetailRoute> {
  final momoDetailBox = objectBox.store.box<MomoDetail>();
  List<MomoDetail> momoDetails = [];
  int page = 1;
  bool loading = false;
  late Momo momo;
  WebScraper webScraperMomo = WebScraper();
  // final database = Provider.of<AppDatabase>(context);

  @override
  void initState() {
    loading = true;
    requestMomoDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    momo = ModalRoute.of(context)?.settings.arguments as Momo;

    return Scaffold(
        appBar: AppBar(
          title: Text('${momo.title}'),
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
        body: _bodyDetail());
  }

  Widget _bodyDetail() {
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
                      return _itemDetail(index);
                    },
                    childCount: momoDetails.length,
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
          return _itemDetail(index);
        },
        itemCount: momoDetails.length,
      ),
    );
  }

  Future _loadMore() async {
    page++;
    requestMomoDetail();
  }

  Widget _itemDetail(int index) {
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
                    momoDetails[index].title!,
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
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: momoDetails[index].imgUrl!,
                    ),
                  ])
                ],
              ),
            ),
            onTap: () {
              // Navigator.pushNamed(context, RouteNames.NEWS_DETAIL,
              //         arguments: momos[index])
              //     .then((value) {
              //   debugPrint("--------$value");
              // });
              print(momoDetails[index]);
            },
          )),
    );
  }

  void requestMomoDetail() {
    Future(() async {
      setState(() {
        loading = true;
      });
      // return await ReptileService().getMomoDetailLocal(detail_id, page);
      return await ReptileService().getMomoDetail(momo.dataPid!, page);
    }).then((value) {
      List<MomoDetail> temp = value!.toList();
      temp.addAll(momoDetails);
      momoDetails = temp;
      momoDetailBox.putManyAsync(momoDetails);
      debugPrint("momoDetails.size=${momoDetails.length}");
      setState(() {
        loading = false;
      });
    });
  }
}
