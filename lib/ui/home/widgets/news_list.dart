import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_c18_dokki/core/utils/extensions.dart';
import 'package:news_c18_dokki/data/api/news_api_client.dart';
import 'package:news_c18_dokki/data/models/articles_response.dart';
import 'package:news_c18_dokki/data/models/sources_response.dart';
import 'package:news_c18_dokki/ui/home/article_details_screen.dart';

// da el sho8l bta3y
class NewsList extends StatefulWidget {
  final List<Sources> sources;

  const NewsList({required this.sources, super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  Sources? selectedSource;

  @override
  void initState() {
    super.initState();
    selectedSource = widget.sources.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: widget.sources.length,
          child: TabBar(
            onTap: (index) {
              setState(() {
                selectedSource = widget.sources[index];
              });
            },
            tabs: widget.sources
                .map(
                  (source) => Text(source.name ?? "").withVerticalPadding(16),
                )
                .toList(),
            isScrollable: true,
            dividerHeight: 0,
            tabAlignment: TabAlignment.start,
          ),
        ),
        Expanded(
          child: FutureBuilder<ArticlesResponse>(
            future: NewsApiClient.instance.getArticles(selectedSource?.id ?? ""),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              } else {
                var articles = snapshot.data?.articles ?? [];
                if (articles.isEmpty) {
                  return const Center(child: Text("No articles found"));
                } else {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (_, index) {
                      var article = articles[index];
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
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: article.urlToImage ?? "",
                                width: double.infinity,
                                height: 230,
                                fit: BoxFit.cover,
                                placeholder: (_, _) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              article.author ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              article.title ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                DateFormat("yyyy-MM-dd").format(
                                  DateTime.tryParse(article.publishedAt ?? "") ??
                                      DateTime.now(),
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 25),
                    itemCount: articles.length,
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
