class Article{
  final String? title;
  final String? author;
  final String? description;
  final String? urlToImage;
  final DateTime publshedAt;
  final String? content;
  final String? articleUrl;

  Article({this.title, this.description, this.author, this.content, required this.publshedAt, this.urlToImage, this.articleUrl});
}