class NewsArticleEntity {
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? sourceName;
  final DateTime? publishedAt;

  NewsArticleEntity({
    required this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.sourceName,
    this.publishedAt,
  });

  factory NewsArticleEntity.fromJson(Map<String, dynamic> json) {
    return NewsArticleEntity(
      title: json['title'] ?? '',
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      sourceName: json['source'] != null ? json['source']['name'] : null,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
    );
  }
}
