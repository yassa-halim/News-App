import 'package:flutter/material.dart';
import 'package:news_c18_dokki/data/api/news_api_client.dart';
import 'package:news_c18_dokki/data/models/articles_response.dart';
import 'package:news_c18_dokki/ui/home/article_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

// da el sho8l bta3y
class SearchPage extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return const Center(child: Text("Search for news..."));

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: FutureBuilder<ArticlesResponse>(
        future: NewsApiClient.instance.getArticlesByQuery(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          var articles = snapshot.data?.articles ?? [];
          if (articles.isEmpty) {
            return const Center(child: Text("No results found"));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) => NewsSearchItem(article: articles[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: articles.length,
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        color: Theme.of(context).colorScheme.surface,
        child: const Center(
            child: Text("Start searching...", style: TextStyle(color: Colors.grey, fontSize: 18))),
      );
    }
    return buildResults(context);
  }
}

class NewsSearchItem extends StatelessWidget {
  final Articles article;
  const NewsSearchItem({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ArticleDetailsScreen.routeName,
          arguments: article,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? "",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (_, _) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 8),
          Text(article.author ?? "", style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(article.title ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
