class Category {
  String name;
  int accessLevel;
  bool? isDelete;
  bool? isUpdate;
  bool? isFinish;
  String? count;
  int id;

  Category({
    required this.name,
    required this.accessLevel,
    this.isDelete,
    this.isUpdate,
    this.isFinish,
    this.count,
    required this.id,
  });

  @override
  String toString() {
    return 'Category(name: $name, accessLevel: $accessLevel, isDelete: $isDelete, isUpdate: $isUpdate, isFinish: $isFinish, count: $count, id: $id)';
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      name: json['name'] as String,
      accessLevel: json['accessLevel'] as int,
      isDelete: json['isDelete'] as bool?,
      isUpdate: json['isUpdate'] as bool?,
      isFinish: json['isFinish'] as bool?,
      count: json['count'] as String?,
      id: json['id'] as int);

  Map<String, dynamic> toJson() => {
        'name': name,
        'accessLevel': accessLevel,
        'isDelete': isDelete,
        'isUpdate': isUpdate,
        'isFinish': isFinish,
        'count': count,
        'id': id,
      };
}
