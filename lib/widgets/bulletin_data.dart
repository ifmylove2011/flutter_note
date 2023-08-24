import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/juhe/bulletin.dart';
import 'package:flutter_note/common/model/juhe/res_juhe.dart';
import 'package:flutter_note/common/model/juhe/result.dart';
import 'package:flutter_note/common/net/http_origin.dart';
import 'package:flutter_note/common/net/juhe_service.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_note/widgets/function_w.dart';

class BulletinList extends StatefulWidget {
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
    return LoadingOverlay(
        isLoading: loading,
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: DecoratedBox(
                    decoration: bd1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
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
                            bulletins[index].digest!,
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
            },
            separatorBuilder: (BuildContext context, int index) {
              return d1;
            },
            itemCount: bulletins.length));
  }

  void requestBulletin() async {
    // Future(() async {
    //   setState(() {
    //     loading = true;
    //   });
    //   return await rootBundle.loadString("assets/data/bulletin.json");
    // }).then((value) {
    //   Response<ResultL<Bulletin>> r =
    //       JSON().fromJsonAs<Response<ResultL<Bulletin>>>(value);
    //   bulletins = r.result!.list!;
    //   setState(() {
    //     loading = false;
    //   });
    // });

    Future(() async {
      setState(() {
        loading = true;
      });
      return await JuheService.getBulletins();
    }).then((value) {
      bulletins = value!;
      setState(() {
        loading = false;
      });
    });
  }
}
