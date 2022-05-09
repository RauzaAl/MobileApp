import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab3/page/news_detail_page.dart';
import 'package:lab3/service/news_api.dart';

class NewsListWidget extends StatelessWidget {
  final DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

  final List<News> news;

  NewsListWidget({
    required this.news,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsDetailPage(news: news[index])
              ),
            );
          },
          title: Text(
            news[index].title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading:
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(news[index].image), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          subtitle: Column(
            children: [
              Text(
                "${news[index].author} - ${format.format(news[index].publishedAt)}".trim(),
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5),
              Text(
                news[index].description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
