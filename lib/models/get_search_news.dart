// To parse this JSON data, do
//
//     final searchedNews = searchedNewsFromJson(jsonString);


import 'dart:convert';

SearchedNews searchedNewsFromJson(String str) => SearchedNews.fromJson(json.decode(str));

String searchedNewsToJson(SearchedNews data) => json.encode(data.toJson());

class SearchedNews {
    SearchedNews({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    final Source source;
    final String author;
    final String title;
    final String description;
    final String url;
          String urlToImage;
    final DateTime publishedAt;
    final String content;


    changeUrlImageLink(String s){
      urlToImage=s;
    }

    factory SearchedNews.fromJson(Map<String, dynamic> json) => SearchedNews(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? "null",
        title: json["title"] ?? "null",
        description: json["description"] ?? "null",
        url: json["url"] ?? "null",
        urlToImage: json["urlToImage"] ?? "null",
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? "null",
    );

    Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
    };
}

class Source {
    Source({
        required this.id,
        required this.name,
    });

    final dynamic id;
    final String name;

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] ?? "null",
        name: json["name"] ?? "null",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
