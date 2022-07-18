class News {
  String uniquekey;
  String title;
  String? date;
  String? category;
  String? authorName;
  String? url;
  String? thumbnailPicS;
  String? thumbnailPicS02;
  String? thumbnailPicS03;
  String? isContent;

  News({
    required this.uniquekey,
    required this.title,
    this.date,
    this.category,
    this.authorName,
    this.url,
    this.thumbnailPicS,
    this.thumbnailPicS02,
    this.thumbnailPicS03,
    this.isContent,
  });

  @override
  String toString() {
    return 'News(uniquekey: $uniquekey, title: $title, date: $date, category: $category, authorName: $authorName, url: $url, thumbnailPicS: $thumbnailPicS, thumbnailPicS02: $thumbnailPicS02, thumbnailPicS03: $thumbnailPicS03, isContent: $isContent)';
  }

  factory News.fromJson(Map<String, dynamic> json) => News(
        uniquekey: json['uniquekey'] as String,
        title: json['title'] as String,
        date: json['date'] as String?,
        category: json['category'] as String?,
        authorName: json['author_name'] as String?,
        url: json['url'] as String?,
        thumbnailPicS: json['thumbnail_pic_s'] as String?,
        thumbnailPicS02: json['thumbnail_pic_s02'] as String?,
        thumbnailPicS03: json['thumbnail_pic_s03'] as String?,
        isContent: json['is_content'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'uniquekey': uniquekey,
        'title': title,
        'date': date,
        'category': category,
        'author_name': authorName,
        'url': url,
        'thumbnail_pic_s': thumbnailPicS,
        'thumbnail_pic_s02': thumbnailPicS02,
        'thumbnail_pic_s03': thumbnailPicS03,
        'is_content': isContent,
      };
}
