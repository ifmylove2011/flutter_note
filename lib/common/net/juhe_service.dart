import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/juhe/bulletin.dart';
import 'package:flutter_note/common/model/juhe/joke.dart';
import 'package:flutter_note/common/model/juhe/news.dart';
import 'package:flutter_note/common/model/juhe/result.dart';
import 'package:flutter_note/common/net/dio_request.dart';
import 'package:flutter_note/common/model/juhe/res_juhe.dart';

class JuheService {
  static const String bulletinKey = "2ec96a8869a74b64cf6bc00f9d6b8414";
  static const String bulletinPath = "/fapigx/bulletin/query";

  static const String jokeKey = "1a2b52bf6fe78d1188264ecbbbd92df9";
  static const String jokePath = "/joke/content/list.php";

  static const String newsKey = "8ef5e2b4ff9bfebb872031f1ae86d3ca";
  static const String newsPath = "/toutiao/index";

  static getBulletins() async {
    var res = await JuheHolder.get()
        .dio
        .get(bulletinPath, queryParameters: {"key": bulletinKey});
    Response<ResultL<Bulletin>> result =
        JSON().fromJsonAs<Response<ResultL<Bulletin>>>(res.toString());
    return result.result!.list;
  }

  static getBulletinsLocal() async {
    var res = await rootBundle.loadString("assets/data/bulletin.json");
    Response<ResultL<Bulletin>> result =
        JSON().fromJsonAs<Response<ResultL<Bulletin>>>(res.toString());
    return result.result!.list;
  }

  static getJoke(int page) async {
    var res = await JuheVHolder.get().dio.get(
      jokePath,
      queryParameters: {
        "key": jokeKey,
        "time": DateTime.now().millisecondsSinceEpoch ~/ 1000,
        "sort": "desc",
        "page": page
      },
    );
    debugPrint(res.toString());
    Response<Result<Joke>> result =
        JSON().fromJsonAs<Response<Result<Joke>>>(res.toString());
    return result.result!.data;
  }

  static getJokeLocal() async {
    var res = await rootBundle.loadString("assets/data/jokes.json");
    Response<Result<Joke>> result =
        JSON().fromJsonAs<Response<Result<Joke>>>(res.toString());
    return result.result!.data;
  }

  static getNews(int page) async {
    var res = await JuheVHolder.get().dio.get(
      newsPath,
      queryParameters: {
        "key": newsKey,
        "type": "top",
        "page": page,
        "is_filter": 1
      },
    );
    debugPrint(res.toString());
    Response<ResultPage<News>> result =
        JSON().fromJsonAs<Response<ResultPage<News>>>(res.toString());
    return result.result!.data;
  }

  static getNewsLocal() async {
    var res = await rootBundle.loadString("assets/data/news.json");
    Response<ResultPage<News>> result =
        JSON().fromJsonAs<Response<ResultPage<News>>>(res.toString());
    return result.result!.data;
  }

  static getNewsUrl(String url) async {
    var res = await JuheVHolder.get().dio.get(
          url,
        );
    return res.toString();
  }
}
