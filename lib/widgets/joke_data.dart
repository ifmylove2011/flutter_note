import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/joke/juhe_joke/joke.dart';
import 'package:flutter_note/common/model/joke/juhe_joke/juhe_res.dart';
import 'package:flutter_note/common/model/joke/juhe_joke/result.dart';
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
                padding: EdgeInsets.all(10),
                child: DecoratedBox(
                    decoration: bd1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: Text(
                        textAlign: TextAlign.left,
                        jokes[index].content!.trimLeft(),
                        textScaleFactor: 2,
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
      return await rootBundle.loadString("/data/jokes.json");
    }).then((value) {
      JuheResponse<Result<Joke>> r =
          JSON().fromJsonAs<JuheResponse<Result<Joke>>>(value);
      setState(() {
        jokes = r.result!.data!;
        print(jokes[2].content);
        var s = JSON().toJson(jokes, false);
        // print(s);
        var jj = JSON().fromJson(s, Joke);
        print(jj.length);
      });
    });
  }
}
