import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class XoxoDetail {
  int? id;
  String? title;
  @Unique()
  String? imgUrl;
  int? detailId;

  XoxoDetail({this.title, this.imgUrl, this.detailId});

  @override
  String toString() {
    return 'XoxoDetail(title: $title, imgUrl: $imgUrl, detailId: $detailId)';
  }

  factory XoxoDetail.fromMap(Map<String, dynamic> data) => XoxoDetail(
        title: data['title'] as String?,
        imgUrl: data['img_url'] as String?,
        detailId: data['detail_id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'img_url': imgUrl,
        'detail_id': detailId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [XoxoDetail].
  factory XoxoDetail.fromJson(Map<String, dynamic> data) {
    return XoxoDetail.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [XoxoDetail] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! XoxoDetail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => title.hashCode ^ imgUrl.hashCode ^ detailId.hashCode;
}
