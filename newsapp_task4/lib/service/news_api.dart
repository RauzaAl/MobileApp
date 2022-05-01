import 'dart:ui';

import 'package:dio/dio.dart';

class NewsAPI {
  String apiKey = "6c4f442015ec40d0a8ad8fdc79043e02";
  String headlinesURL = "https://newsapi.org/v2/top-headlines?country=us&pageSize=10";

  late Dio _dio;

  NewsAPI() {
    _dio = Dio();
    _dio.options.headers["Authorization"] = "Bearer $apiKey";
  }

  Future<List<News>> listAll() async {
    try {
      Response res = await _dio.get(headlinesURL);
      NewsResponse body = NewsResponse.fromJson(res.data);
      return body.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }

  Future<List<News>> listByCategory(String category) async {
    try {
      Response res = await _dio.get(headlinesURL + "&category=$category");
      NewsResponse body = NewsResponse.fromJson(res.data);
      return body.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}

class NewsResponse {
  List<News> data;

  NewsResponse({
    required this.data,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    data: List<News>.from(json["articles"].map((n) => News.fromJson(n))),
  );
}

class News {
  String title;
  String description;
  DateTime publishedAt;
  String author;
  String image;

  News({
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.author,
    required this.image,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    title: json["title"],
    description: json["description"].toString(),
    publishedAt: DateTime.parse(json["publishedAt"]),
    author: json["author"] ?? "Unknown",
    image: json["urlToImage"].toString(),
  );
}
