class NewsModel{

  final String title;
  final String description;
  final String publishedAt;
  final String urlToImage;
  final String author;

  NewsModel(
      {
      required this.title,
      required this.author,
      required this.description,
      required this.publishedAt,
      required this.urlToImage
      });  
 
    Map<String, dynamic> toJson() {
      return {
      "title" : title,
      "description" : description,
      "publishedAt" : publishedAt
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ,
      author : json['author'] ?? 'Annonymous',
      description: json['description'],
      publishedAt: json['publishedAt'],
      urlToImage: json['urlToImage']
    );
  }

 
}


