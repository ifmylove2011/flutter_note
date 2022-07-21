class Note {
  int id;
  String title;
  String? abstractContent;
  String? content;
  int? isDelete;
  int? isUpdate;
  int? isFinish;
  String? password;
  String? passwordHint;
  String? sourceUrl;
  int? encrypted;
  String? createTime;
  String? updateTime;
  String? lastViewTime;
  int? cateId;

  Note({
    required this.id,
    required this.title,
    this.abstractContent,
    this.content,
    this.isDelete,
    this.isUpdate,
    this.isFinish,
    this.password,
    this.passwordHint,
    this.sourceUrl,
    this.encrypted,
    this.createTime,
    this.updateTime,
    this.lastViewTime,
    this.cateId,
  });

  @override
  String toString() {
    return 'Note(id: $id, title: $title, abstractContent: $abstractContent, content: $content, isDelete: $isDelete, isUpdate: $isUpdate, isFinish: $isFinish, password: $password, passwordHint: $passwordHint, sourceUrl: $sourceUrl, encrypted: $encrypted, createTime: $createTime, updateTime: $updateTime, lastViewTime: $lastViewTime, cateId: $cateId)';
  }

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['_id'] as int,
        title: json['title'] as String,
        abstractContent: json['abstractContent'] as String?,
        content: json['content'] as String?,
        isDelete: json['isDelete'] as int?,
        isUpdate: json['isUpdate'] as int?,
        isFinish: json['isFinish'] as int?,
        password: json['password'] as String?,
        passwordHint: json['passwordHint'] as String?,
        sourceUrl: json['sourceUrl'] as String?,
        encrypted: json['encrypted'] as int?,
        createTime: json['createTime'] as String?,
        updateTime: json['updateTime'] as String?,
        lastViewTime: json['lastViewTime'] as String?,
        cateId: json['cateId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'abstractContent': abstractContent,
        'content': content,
        'isDelete': isDelete,
        'isUpdate': isUpdate,
        'isFinish': isFinish,
        'password': password,
        'passwordHint': passwordHint,
        'sourceUrl': sourceUrl,
        'encrypted': encrypted,
        'createTime': createTime,
        'updateTime': updateTime,
        'lastViewTime': lastViewTime,
        'cateId': cateId,
      };
}
