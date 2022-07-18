class Note {
  int id;
  String title;
  String? abstractContent;
  String? content;
  bool? isDelete;
  bool? isUpdate;
  bool? isFinish;
  String? password;
  String? passwordHint;
  String? sourceUrl;
  String? encrypted;
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
        id: json['id'] as int,
        title: json['title'] as String,
        abstractContent: json['abstractContent'] as String?,
        content: json['content'] as String?,
        isDelete: json['isDelete'] as bool?,
        isUpdate: json['isUpdate'] as bool?,
        isFinish: json['isFinish'] as bool?,
        password: json['password'] as String?,
        passwordHint: json['passwordHint'] as String?,
        sourceUrl: json['sourceUrl'] as String?,
        encrypted: json['encrypted'] as String?,
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
