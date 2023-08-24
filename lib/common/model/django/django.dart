import 'package:flutter_note/common/model/convert.dart';

import 'note.dart';

class Django<T> {
  int? code;
  String? message;
  String? processTime;
  T? data;

  Django({this.code, this.message, this.processTime, this.data});

  factory Django.fromJson(Map<String, dynamic> json) => Django(
        code: json['code'] as int?,
        message: json['message'] as String?,
        processTime: json['processTime'] as String?,
        data: JSON().fromJson(json['data'], T) as T,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'processTime': processTime,
        'data': JSON().toJson(data, false),
      };
}
