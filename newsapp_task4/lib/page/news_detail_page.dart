import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab3/service/news_api.dart';

class NewsDetailPage extends StatelessWidget {
  final DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

  final News news;

  NewsDetailPage({
    required this.news,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(news.image), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              news.title,
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 10),
            Text(
              news.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Published at ${format.format(news.publishedAt)}",
              maxLines: 1,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              "By ${news.author}",
              maxLines: 1,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
