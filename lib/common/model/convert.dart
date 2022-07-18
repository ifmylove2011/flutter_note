import 'package:flutter_note/common/model/juhe/news.dart';
import 'package:flutter_note/common/model/juhe/result.dart';

class JsonConvert {
  static T fromJsonAs<T>(Type type, Map<String, dynamic> json) {
    switch (type.toString()) {
      case 'ResultJuhe<News>':
        return ResultJuhe<News>.fromJson(json) as T;
      case 'News':
        return News.fromJson(json) as T;
    }
    return type as T;
  }

  static Map<String, dynamic> toJson<T>(T? data) {
    switch (data.runtimeType) {
      case News:
        return (data as News).toJson();
    }
    return <String, dynamic>{};
  }
}
