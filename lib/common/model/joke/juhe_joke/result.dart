import 'package:flutter_note/common/model/convert.dart';

class Result<T> {
  List<T>? data;

  Result({this.data});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => JSON().fromJson(e as Map<String, dynamic>,T) as T)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => JSON().toJson(e, false)).toList(),
      };
}
