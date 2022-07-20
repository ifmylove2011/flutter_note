import 'package:flutter_note/common/model/convert.dart';

class JuheResponse<T> {
  int? errorCode;
  String? reason;
  T? result;

  JuheResponse({this.errorCode, this.reason, this.result});

  factory JuheResponse.fromJson(Map<String, dynamic> json) => JuheResponse(
        errorCode: json['error_code'] as int?,
        reason: json['reason'] as String?,
        result: json['result'] == null
            ? null
            : JSON().fromJson(json['result'] as Map<String, dynamic>,T) as T,
      );

  Map<String, dynamic> toJson() => {
        'error_code': errorCode,
        'reason': reason,
        'result': JSON().toJson(result, false),
      };
}
