import 'package:flutter/material.dart';
import 'package:news_c18_dokki/core/providers/app_config_provider.dart';
import 'package:news_c18_dokki/core/theme/app_colors.dart';
import 'package:news_c18_dokki/core/theme/theme.dart';
import 'package:news_c18_dokki/ui/home/article_details_screen.dart';
import 'package:news_c18_dokki/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppConfigProvider(),
      child: Consumer<AppConfigProvider>(
        builder: (context, provider, child) => MaterialApp(
          theme: AppTheme(LightAppColors()).theme,
          darkTheme: AppTheme(DarkAppColors()).theme,
          themeMode: provider.themeMode,
          routes: {
            HomeScreen.routeName :(_)=> HomeScreen(),
            ArticleDetailsScreen.routeName: (_) => const ArticleDetailsScreen(),
          },
          initialRoute: HomeScreen.routeName,
        ),
      ),
    );
  }
}
