import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MeiYingDetail {
  int? id;
  String? imgUrl;
  int? detailId;

  MeiYingDetail({this.imgUrl, this.detailId});

  @override
  String toString() => 'MeiYingDetail(imgUrl: $imgUrl, detailId: $detailId)';

  factory MeiYingDetail.fromMap(Map<String, dynamic> data) => MeiYingDetail(
        imgUrl: data['img_url'] as String?,
        detailId: data['detail_id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'img_url': imgUrl,
        'detail_id': detailId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MeiYingDetail].
  factory MeiYingDetail.fromJson(Map<String, dynamic> data) {
    return MeiYingDetail.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [MeiYingDetail] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MeiYingDetail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => imgUrl.hashCode ^ detailId.hashCode;
}
