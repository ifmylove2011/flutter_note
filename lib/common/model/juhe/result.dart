import 'package:flutter_note/common/model/convert.dart';

class ResultPage<T> {
  String? stat;
  List<T>? data;
  String? page;
  String? pageSize;

  ResultPage({this.stat, this.data, this.page, this.pageSize});

  factory ResultPage.fromJson(Map<String, dynamic> json) => ResultPage(
        stat: json['stat'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => JSON().fromJson(e as Map<String, dynamic>, T) as T)
            .toList(),
        page: json['page'] as String?,
        pageSize: json['pageSize'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'stat': stat,
        'data': data?.map((e) => JSON().toJson(T, false)).toList(),
        'page': page,
        'pageSize': pageSize,
      };
}

class Result<T> {
  List<T>? data;

  Result({this.data});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => JSON().fromJson(e as Map<String, dynamic>, T) as T)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => JSON().toJson(e, false)).toList(),
      };
}

class ResultL<T> {
  List<T>? list;

  ResultL({this.list});

  factory ResultL.fromJson(Map<String, dynamic> json) => ResultL(
        list: (json['list'] as List<dynamic>?)
            ?.map((e) => JSON().fromJson(e as Map<String, dynamic>, T) as T)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'list': list?.map((e) => JSON().toJson(e, false)).toList(),
      };
}
