class Joke {
  String? content;
  String? hashId;
  int? unixtime;
  String? updatetime;

  Joke({this.content, this.hashId, this.unixtime, this.updatetime});

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(
        content: json['content'] as String?,
        hashId: json['hashId'] as String?,
        unixtime: json['unixtime'] as int?,
        updatetime: json['updatetime'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'content': content,
        'hashId': hashId,
        'unixtime': unixtime,
        'updatetime': updatetime,
      };
}
