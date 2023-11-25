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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:objectbox/objectbox.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_note/generated/l10n.dart';
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
  int pageNum = 0;
  bool loading = false;
  int currentIndex = 0;
  int layout = 0;
  late Momo momo;
  double currentOffet = 0;
  WebScraper webScraperMomo = WebScraper();
  late ScrollController _scrollController;
  // final database = Provider.of<AppDatabase>(context);
  late FToast fToast;

  @override
  void initState() {
    loading = true;
    fToast = FToast();
    fToast.init(context);
    requestMomoDetail();
    _scrollController = ScrollController(onAttach: (pos) {
      if (_scrollController != null && _scrollController!.hasClients) {
        // _scrollController!.jumpTo(currentOffet);
        if (currentOffet > 0) {
          _scrollController!.animateTo(currentOffet,
              duration: const Duration(milliseconds: 2000), curve: Curves.ease);
        }
      }
    });

    _scrollController.addListener(() {
      currentOffet = _scrollController.offset;
      if (_scrollController.position.extentAfter == 0) {
        _loadMore();
      }
    });
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
                if (layout == 0) {
                  Navigator.of(context).pop();
                } else {
                  layout = 0;
                  setState(() {});
                }
              },
            );
          }),
        ),
        body: layout == 0 ? _bodyDetail() : _photoView());
  }

  Widget _photoView() {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(momoDetails[index].imgUrl!),
          initialScale: PhotoViewComputedScale.contained,
          heroAttributes: PhotoViewHeroAttributes(tag: momoDetails[index].id!),
        );
      },
      itemCount: momoDetails.length,
      loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: 30.0,
          height: 30.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      ),
      backgroundDecoration: const BoxDecoration(color: Colors.black45),
      pageController: PageController(initialPage: currentIndex),
      onPageChanged: (i) {
        currentIndex = i;
      },
    );
  }

  Widget _bodyDetail() {
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
        controller: _scrollController,
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

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("没有更多"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  Future _loadMore() async {
    print("loading more ...当前页-$page");
    if (page >= pageNum) {
      print("no more");
      _showToast();
    } else {
      page++;
      requestMomoDetail();
    }
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
                    momoDetails[index].id.toString(),
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
                      url: momoDetails[index].imgUrl!,
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
                    //   image: momoDetails[index].imgUrl!,
                    // ),
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
              currentIndex = index;
              layout = 1;
              print("scroll ${_scrollController.hasClients}");
              setState(() {});
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
      if (temp.isNotEmpty && pageNum == 0) {
        pageNum = temp[0].pageNum!;
        print("总页数-$pageNum");
      }
      temp.addAll(momoDetails);
      momoDetails = temp.toSet().toList();
      momoDetails.sort((a, b) => a.id!.compareTo(b.id!));
      debugPrint("momoDetails.size=${momoDetails.length}");
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _scrollController.dispose();
    super.dispose();
  }
}
