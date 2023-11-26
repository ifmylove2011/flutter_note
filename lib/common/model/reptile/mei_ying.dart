import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MeiYing {
  @Id(assignable: true)
  int? id;
  String? title;
  String? detailUrl;
  String? postUrl;
  String? descNum;
  String? author;
  int? page;

  MeiYing({
    this.id,
    this.title,
    this.detailUrl,
    this.postUrl,
    this.descNum,
    this.author,
    this.page,
  });

  @override
  String toString() {
    return 'MeiYing(id: $id, title: $title, detailUrl: $detailUrl, postUrl: $postUrl, descNum: $descNum, author: $author, page: $page)';
  }

  factory MeiYing.fromMap(Map<String, dynamic> data) => MeiYing(
        id: data['id'] as int?,
        title: data['title'] as String?,
        detailUrl: data['detail_url'] as String?,
        postUrl: data['post_url'] as String?,
        descNum: data['desc_num'] as String?,
        author: data['author'] as String?,
        page: data['page'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'detail_url': detailUrl,
        'post_url': postUrl,
        'desc_num': descNum,
        'author': author,
        'page': page,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MeiYing].
  factory MeiYing.fromJson(Map<String, dynamic> data) {
    return MeiYing.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [MeiYing] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MeiYing) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      detailUrl.hashCode ^
      postUrl.hashCode ^
      descNum.hashCode ^
      author.hashCode ^
      page.hashCode;
}
