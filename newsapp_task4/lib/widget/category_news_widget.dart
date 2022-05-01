import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab3/service/news_api.dart';
import 'package:lab3/widget/news_list_widget.dart';

class CategoryNewsWidget extends StatefulWidget {
  const CategoryNewsWidget({Key? key}) : super(key: key);

  @override
  State<CategoryNewsWidget> createState() => _CategoryNewsWidgetState();
}

class _CategoryNewsWidgetState extends State<CategoryNewsWidget> {
  final DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
  final List<String> categories = <String>[
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  String category = "business";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Category",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: DropdownButton<String>(
                value: category,
                underline: Container(
                  height: 3,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    category = newValue!;
                  });
                },
                items: categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Expanded(
          child: FutureBuilder<List<News>>(
            future: NewsAPI().listByCategory(category),
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
