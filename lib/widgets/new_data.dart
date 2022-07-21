import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/juhe/news.dart';
import 'package:flutter_note/common/model/juhe/res_juhe.dart';
import 'package:flutter_note/common/model/juhe/result.dart';
import 'package:flutter_note/common/model/django/note.dart';
import 'package:flutter_note/widgets/derate.dart';

class NewsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsListState();
  }
}

class _NewsListState extends State<NewsList> {
  List<News> news = [];

  @override
  void initState() {
    super.initState();
    requestNote();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: DecoratedBox(
                    decoration: bd1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: Text(
                        news[index].title,
                        textScaleFactor: 2,
                      ),
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return d1;
            },
            itemCount: news.length));
  }

  void requestNote() async {
    Future(() async {
      //TODO 请求
      return await rootBundle.loadString("/data/news.json");
    }).then((value) {
      //TODO 赋值
      // Note note = JSON().fromJsonAs<Note>(json.decode(value));
      // ResJuhe<ResultJuhe<News>> r = ResJuhe<ResultJuhe<News>>.fromJson(json.decode(value));
      // ResJuhe<ResultJuhe<News>> r = JSON().fromJson(value,ResJuhe<ResultJuhe<News>>);
      Response<ResultPage<News>> r =
          JSON().fromJsonAs<Response<ResultPage<News>>>(value);
      setState(() {
        news = r.result!.data!;
        // print(news.length);
        // JSON().toJson(news);
      });
    });
    // Future.delayed(Duration(seconds: 2)).then((value) => {

    // });
  }
}
