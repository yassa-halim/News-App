import 'package:flutter/material.dart';
import 'package:news_c18_dokki/core/utils/extensions.dart';
import 'package:news_c18_dokki/data/api/api_client.dart';
import 'package:news_c18_dokki/data/api/news_api_client.dart';
import 'package:news_c18_dokki/data/models/articles_response.dart';
import 'package:news_c18_dokki/data/models/category.dart';
import 'package:news_c18_dokki/data/models/sources_response.dart';
import 'package:news_c18_dokki/ui/home/widgets/news_list.dart';

class NewsTab extends StatefulWidget {
  final Category category;

  const NewsTab({required this.category, super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> with SingleTickerProviderStateMixin {
  List<Sources> sources = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NewsApiClient.instance.getSources(widget.category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        } else {
          sources = snapshot.data?.sources ?? [];
          return NewsList(sources: sources);
        }
      },
    );
  }
}
