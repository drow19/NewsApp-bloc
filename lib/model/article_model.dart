class ArticleModel {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  DateTime publishedAt;

  ArticleModel(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.content,
      this.publishedAt});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        author: json['author'] ?? "",
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        url: json['url'] ?? "",
        urlToImage: json['urlToImage'] ?? "",
        content: json['content'] ?? "",
        publishedAt: DateTime.parse(json['publishedAt']));
  }
}
