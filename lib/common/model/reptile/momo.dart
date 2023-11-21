import 'dart:convert';

import 'package:collection/collection.dart';

class Momo {
  String? title;
  String? detailUrl;
  String? postUrl;
  String? dataPid;
  String? descNum;

  Momo({
    this.title,
    this.detailUrl,
    this.postUrl,
    this.dataPid,
    this.descNum,
  });

  @override
  String toString() {
    return 'Momo(title: $title, detailUrl: $detailUrl, postUrl: $postUrl, dataPid: $dataPid, descNum: $descNum)';
  }

  factory Momo.fromMap(Map<String, dynamic> data) => Momo(
        title: data['title'] as String?,
        detailUrl: data['detail_url'] as String?,
        postUrl: data['post_url'] as String?,
        dataPid: data['data-pid'] as String?,
        descNum: data['desc_num'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'detail_url': detailUrl,
        'post_url': postUrl,
        'data-pid': dataPid,
        'desc_num': descNum,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Momo].
  factory Momo.fromJson(Map<String, dynamic> data) {
    return Momo.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [Momo] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Momo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      title.hashCode ^
      detailUrl.hashCode ^
      postUrl.hashCode ^
      dataPid.hashCode ^
      descNum.hashCode;
}
