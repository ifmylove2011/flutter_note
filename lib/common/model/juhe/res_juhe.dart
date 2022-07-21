import 'package:flutter_note/common/model/convert.dart';

import 'result.dart';

class Response<T> {
  String? reason;
  T? result;
  int? errorCode;

  Response({this.reason, this.result, this.errorCode});

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        reason: json['reason'] as String?,
        result: json['result'] == null
            ? null
            : JSON().fromJson(json['result'] as Map<String, dynamic>, T) as T,
        errorCode: json['error_code'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'reason': reason,
        'result': JSON().toJson(result, false),
        'error_code': errorCode,
      };
}
