import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab3/service/news_api.dart';
import 'package:lab3/widget/news_list_widget.dart';

class AllNewsWidget extends StatelessWidget {
  final DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

  AllNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<News>>(
            future: NewsAPI().listAll(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ));
              }
              return NewsListWidget(news: snapshot.data!);
            },
          ),
        ),
      ],
    );
  }
}
