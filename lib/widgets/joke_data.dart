import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/juhe/joke.dart';
import 'package:flutter_note/common/model/juhe/res_juhe.dart';
import 'package:flutter_note/common/model/juhe/result.dart';
import 'package:flutter_note/widgets/derate.dart';

class JokeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JokeListState();
  }
}

class _JokeListState extends State<JokeList> {
  List<Joke> jokes = [];

  @override
  void initState() {
    super.initState();
    requestJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                            jokes[index].hashId!.trimLeft(),
                            textScaleFactor: 1.5,
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            trimAbstract(jokes[index].content!).trimLeft(),
                            textScaleFactor: 1,
                          ),
                          Text(
                            style: const TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                            jokes[index].updatetime!,
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
            itemCount: jokes.length));
  }

  void requestJoke() async {
    Future(() async {
      return await rootBundle.loadString("assets/data/jokes.json");
    }).then((value) {
      Response<Result<Joke>> r =
          JSON().fromJsonAs<Response<Result<Joke>>>(value);
      setState(() {
        jokes = r.result!.data!;
        print(jokes[2].content);
        var s = JSON().toJson(jokes, false);
        // print(s);
        var jj = JSON().fromJson(s, List<Joke>);
        print(jj.length);
      });
    });
  }

  String trimAbstract(String src) {
    print("----" + src);
    String abstractContent;
    if (src.length > 60) {
      abstractContent = src.substring(0, 60);
      int endIndex = abstractContent.lastIndexOf("。");
      if (endIndex == -1) {
        endIndex = abstractContent.lastIndexOf("，");
      }
      if (endIndex == -1) {
        endIndex = abstractContent.lastIndexOf(",");
      }
      if (endIndex == -1) {
        endIndex = abstractContent.lastIndexOf("\r\n") - 1;
      }
      if (endIndex == -1) {
        endIndex = abstractContent.lastIndexOf("\n") - 1;
      }
      if (endIndex <= 0) {
        endIndex = 60;
      }
      print("end=$endIndex");
      abstractContent = abstractContent.substring(0, endIndex + 1);
    } else {
      abstractContent = src;
    }
    print(abstractContent);
    return abstractContent;
  }
}
