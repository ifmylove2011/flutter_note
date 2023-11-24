import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter_note/common/model/reptile/momo.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MomoDetail {
  @Id(assignable: true)
  int? id;
  String? title;
  String? imgUrl;
  int? detailId;
  int? page;
  int? pageNum;

  final momo = ToOne<Momo>();

  MomoDetail(
      {this.id,
      this.title,
      this.imgUrl,
      this.detailId,
      this.page,
      this.pageNum});

  @override
  String toString() {
    return 'MomoDetail(id: $id, title: $title, imgUrl: $imgUrl, detailId: $detailId, page: $page)';
  }

  factory MomoDetail.fromMap(Map<String, dynamic> data) => MomoDetail(
        id: data['id'] as int?,
        title: data['title'] as String?,
        imgUrl: data['img_url'] as String?,
        detailId: data['detail_id'] as int?,
        page: data['page'] as int?,
        pageNum: data['page_num'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'img_url': imgUrl,
        'detail_id': detailId,
        'page': page,
        'page_num': pageNum,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MomoDetail].
  factory MomoDetail.fromJson(Map<String, dynamic> data) {
    return MomoDetail.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [MomoDetail] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MomoDetail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ detailId.hashCode ^ page.hashCode;
}
