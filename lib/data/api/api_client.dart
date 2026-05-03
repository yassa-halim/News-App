import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:news_c18_dokki/data/models/articles_response.dart';
import 'package:news_c18_dokki/data/models/category.dart';
import 'package:news_c18_dokki/data/models/sources_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Deprecated("no longer user")
class ApiClient {
  static ApiClient? _instance;

  final Dio _dio = Dio();

  Category? _selectedCategory;
  SourcesResponse? _currentSourcesResponse;

  ApiClient._() {
    _dio.options = BaseOptions(
      baseUrl: "https://newsapi.org/",
      receiveTimeout: Duration(seconds: 60),
      connectTimeout: Duration(seconds: 60),
      sendTimeout: Duration(seconds: 60),
    );
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer 2c58c6392813448996cbedf8b2cd9b2e",
    };
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        maxWidth: 140,
        enabled: kDebugMode,
      ),
    );
  }

  static ApiClient get instance => _instance ??= ApiClient._();

  Future<SourcesResponse> getSources(Category category) async {
    if (_selectedCategory?.id == category.id) {
      return _currentSourcesResponse!;
    }
    var response = await _dio.get(
      "v2/top-headlines/sources",
      queryParameters: {"category": category.id},
    );
    _selectedCategory = category;
    _currentSourcesResponse = SourcesResponse.fromJson(response.data);
    return _currentSourcesResponse!;
  }

  void resetApi() {
    _selectedCategory = null;
    _currentSourcesResponse = null;
  }

  Future<ArticlesResponse> getArticles(String sourceId) async {
    var response = await _dio.get(
      "v2/top-headlines",
      queryParameters: {"sources": sourceId},
    );
    return ArticlesResponse.fromJson(response.data);
  }
}
