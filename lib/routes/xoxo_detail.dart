import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/model/reptile/xoxo_detail.dart';
import 'package:flutter_note/common/net/reptile_service.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_scraper/web_scraper.dart';
import '../common/model/reptile/xoxo.dart';
import '../widgets/function_w.dart';

class XoxoDetailRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _XoxoDetailRouteState();
  }
}

class _XoxoDetailRouteState extends State<XoxoDetailRoute> {
  List<XoxoDetail> xoxoDetails = [];
  bool loading = false;
  int currentIndex = 0;
  int layout = 0;
  late Xoxo xoxo;
  double currentOffet = 0;
  var layoutStyle = Layout.grid.index;

  @override
  void initState() {
    loading = true;
    Future(() async {
      return await SharedPreferences.getInstance();
    }).then((prefs) {
      layoutStyle =
          prefs.getInt(Constant.DETAIL_LAYOUT_STYLE) ?? Layout.grid.index;
    });
    requestMeiyingDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    xoxo = ModalRoute.of(context)?.settings.arguments as Xoxo;

    return Scaffold(
      body: PopScope(
          canPop: layout == 0,
          onPopInvoked: (bool pop) {
            if (!pop) {
              layout = 0;
              setState(() {});
            }
          },
          child: nestedBody()),
    );
  }

  Widget nestedBody() {
    return NestedScrollView(
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
                    if (layout == 0) {
                      Navigator.of(context).pop();
                    } else {
                      layout = 0;
                      setState(() {});
                    }
                  },
                );
              }),
              title: Text(xoxo.title!),
              pinned: false,
              snap: true,
              floating: true,
              actions: [
                IconButton(
                    onPressed: _switchLayoutGrid,
                    icon: Icon(
                        layoutStyle == Layout.list.index
                            ? Icons.list
                            : Icons.grid_on,
                        color: Colors.lightGreen)),
              ],
            ),
          ),
        ];
      },
      body: Builder(builder: (BuildContext context) {
        return layout == 0 ? _bodyDetail(context) : _photoView();
      }),
    );
  }

  /// 切换列表/方格/瀑布视图
  void _switchLayoutGrid() {
    if (layoutStyle == Layout.list.index) {
      layoutStyle = Layout.monsonry.index;
    } else {
      layoutStyle = Layout.list.index;
    }
    Future(() async {
      return await SharedPreferences.getInstance();
    }).then((prefs) {
      prefs.setInt(Constant.DETAIL_LAYOUT_STYLE, layoutStyle);
    });
    debugPrint("layoutStyle=$layoutStyle");
    setState(() {});
  }

  Widget _photoView() {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(xoxoDetails[index].imgUrl!),
          initialScale: PhotoViewComputedScale.contained,
          heroAttributes:
              PhotoViewHeroAttributes(tag: xoxoDetails[index].imgUrl!),
        );
      },
      itemCount: xoxoDetails.length,
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

  Widget _bodyDetail(BuildContext context) {
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
                      return _itemDetail(index);
                    },
                    childCount: xoxoDetails.length,
                  ),
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: layoutStyle == 0 ? 1 : 2,
                  )),
            ],
          ));
    }
    return LoadingOverlay(
      isLoading: loading,
      child: MasonryGridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: layoutStyle == 0 ? 1 : 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _itemDetail(index);
        },
        itemCount: xoxoDetails.length,
      ),
    );
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
                      xoxoDetails[index].title!),
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
                      url: xoxoDetails[index].imgUrl!,
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
              print(xoxoDetails[index]);
              currentIndex = index;
              layout = 1;
              setState(() {});
            },
          )),
    );
  }

  void requestMeiyingDetail() {
    Future(() async {
      setState(() {
        loading = true;
      });
      // return await ReptileService().getMomoDetailLocal(detail_id, page);
      return await ReptileService().getXoxoDetail(xoxo.id!);
    }).then((value) {
      List<XoxoDetail> temp = value!.toList();
      xoxoDetails = temp.toSet().toList();
      xoxoDetails.sort((a, b) => a.imgUrl!.compareTo(b.imgUrl!));
      debugPrint("xoxoDetails.size=${xoxoDetails.length}");
      setState(() {
        loading = false;
      });
    });
  }
}
