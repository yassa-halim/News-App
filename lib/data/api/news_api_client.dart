import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_c18_dokki/data/models/articles_response.dart';
import 'package:news_c18_dokki/data/models/sources_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_client.g.dart';

@RestApi(baseUrl: "https://newsapi.org/")
abstract class NewsApiClient {
  static NewsApiClient? _instance;

  static NewsApiClient get instance {
    if(_instance != null) return _instance!;
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: "https://newsapi.org/",
      receiveTimeout: Duration(seconds: 60),
      connectTimeout: Duration(seconds: 60),
      sendTimeout: Duration(seconds: 60),
    );
    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer 2c58c6392813448996cbedf8b2cd9b2e",
    };
    dio.interceptors.add(
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
    return _instance ??= NewsApiClient._(dio);
  }

  factory NewsApiClient._(Dio dio) = _NewsApiClient;



  @GET("v2/top-headlines/sources")
  Future<SourcesResponse> getSources(@Query("category") String categoryId);


  @GET("v2/top-headlines")
  Future<ArticlesResponse> getArticles(@Query("sources") String sourceId);

  @GET("v2/everything")
  Future<ArticlesResponse> getArticlesByQuery(@Query("q") String query);
}
