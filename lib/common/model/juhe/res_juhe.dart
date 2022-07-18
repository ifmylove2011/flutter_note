import 'package:flutter_note/common/model/convert.dart';

import 'result.dart';

class ResJuhe<T> {
  String? reason;
  T? result;
  int? errorCode;

  ResJuhe({this.reason, this.result, this.errorCode});

  factory ResJuhe.fromJson(Map<String, dynamic> json) => ResJuhe(
        reason: json['reason'] as String?,
        result: json['result'] == null
            ? null
            : JsonConvert.fromJsonAs(T,json['result'] as Map<String, dynamic>),
        errorCode: json['error_code'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'reason': reason,
        'result': JsonConvert.toJson<T>(result),
        'error_code': errorCode,
      };
}