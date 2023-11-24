import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter_note/common/model/reptile/momo_detail.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Momo {
  String? title;
  String? detailUrl;
  String? postUrl;
  @Id(assignable: true)
  int? dataPid;
  @Property(uid: 3724144874425576011)
  String? descNum;
  int? page;

  @Backlink('momo')
  final details = ToMany<MomoDetail>();

  Momo(
      {this.title,
      this.detailUrl,
      this.postUrl,
      this.dataPid,
      this.descNum,
      this.page});

  @override
  String toString() {
    return 'Momo(title: $title, detailUrl: $detailUrl, postUrl: $postUrl, dataPid: $dataPid, descNum: $descNum, page: $page)';
  }

  factory Momo.fromMap(Map<String, dynamic> data) => Momo(
        title: data['title'] as String?,
        detailUrl: data['detail_url'] as String?,
        postUrl: data['post_url'] as String?,
        dataPid: data['data-pid'] as int?,
        descNum: data['desc_num'] as String?,
        page: data['page'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'detail_url': detailUrl,
        'post_url': postUrl,
        'data-pid': dataPid,
        'desc_num': descNum,
        'page': page,
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
  int get hashCode => dataPid.hashCode;
}
