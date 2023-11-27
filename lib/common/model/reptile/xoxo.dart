import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Xoxo {
  @Id(assignable: true)
  int? id;
  String? title;
  String? detailUrl;
  String? postUrl;
  int? page;

  Xoxo({this.id, this.title, this.detailUrl, this.postUrl, this.page});

  @override
  String toString() {
    return 'Xoxo(id: $id, title: $title, detailUrl: $detailUrl, postUrl: $postUrl, page: $page)';
  }

  factory Xoxo.fromMap(Map<String, dynamic> data) => Xoxo(
        id: data['id'] as int?,
        title: data['title'] as String?,
        detailUrl: data['detail_url'] as String?,
        postUrl: data['post_url'] as String?,
        page: data['page'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'detail_url': detailUrl,
        'post_url': postUrl,
        'page': page,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Xoxo].
  factory Xoxo.fromJson(Map<String, dynamic> data) {
    return Xoxo.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [Xoxo] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Xoxo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      detailUrl.hashCode ^
      postUrl.hashCode ^
      page.hashCode;
}
