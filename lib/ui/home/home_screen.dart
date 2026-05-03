import 'package:flutter/material.dart';
import 'package:news_c18_dokki/core/providers/app_config_provider.dart';
import 'package:news_c18_dokki/data/models/category.dart';
import 'package:news_c18_dokki/ui/home/search_page.dart';
import 'package:news_c18_dokki/ui/home/taba/home_tab.dart';
import 'package:news_c18_dokki/ui/home/taba/news_tab.dart';
import 'package:news_c18_dokki/ui/home/widgets/home_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return PopScope(
      canPop: selectedCategory == null,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        setState(() {
          selectedCategory = null;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            selectedCategory == null ? "Home" : selectedCategory?.name ?? "",
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchPage());
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        drawer: HomeDrawer(
          onHomePress: () {
            setState(() {
              selectedCategory = null;
            });
            Navigator.pop(context); // قفل الـ drawer بعد الضغط
          },
        ),
        body: selectedCategory == null
            ? HomeTab(
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              )
            : NewsTab(category: selectedCategory!),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            provider.toggleTheme();
          },
          child: const Icon(Icons.color_lens),
        ),
      ),
    );
  }
}
