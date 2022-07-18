import 'package:flutter_note/common/model/convert.dart';

class ResultJuhe<T> {
  String? stat;
  List<T>? data;
  String? page;
  String? pageSize;

  ResultJuhe({this.stat, this.data, this.page, this.pageSize});

  factory ResultJuhe.fromJson(Map<String, dynamic> json) => ResultJuhe(
        stat: json['stat'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => JsonConvert.fromJsonAs<T>(T,e as Map<String, dynamic>))
            .toList(),
        page: json['page'] as String?,
        pageSize: json['pageSize'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'stat': stat,
        'data': data?.map((e) => JsonConvert.toJson(T)).toList(),
        'page': page,
        'pageSize': pageSize,
      };
}
