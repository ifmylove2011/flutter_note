class Bulletin {
  String? mtime;
  String? title;
  String? digest;

  Bulletin({this.mtime, this.title, this.digest});

  @override
  String toString() =>
      'Bulletin(mtime: $mtime, title: $title, digest: $digest)';

  factory Bulletin.fromJson(Map<String, dynamic> data) => Bulletin(
        mtime: data['mtime'] as String?,
        title: data['title'] as String?,
        digest: data['digest'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'mtime': mtime,
        'title': title,
        'digest': digest,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Bulletin) return false;
    return other.hashCode == hashCode;
  }

  @override
  int get hashCode => mtime.hashCode ^ title.hashCode;
}
