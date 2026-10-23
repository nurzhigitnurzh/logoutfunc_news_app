import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:home1/features/news/data/model/news_article_model.dart';
import 'package:home1/features/news/data/remote/api/news_data_source.dart';

abstract final class _ApiPath {
  static const String everything = 'https://newsapi.org/v2/everything';
  static const String apiKey = String.fromEnvironment(
    'NEWS_API_KEY',
    defaultValue: '8d5c10496ef24e55b326ef3524c1faf3',
  );
}

@LazySingleton(as: NewsDataSource)
class NewsDataSourceImpl implements NewsDataSource {
  const NewsDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<NewsArticleModel>> getEverything(
    String query, {
    required int page,
    required int pageSize,
  }) async {
    try {
      final from = DateTime.now()
          .subtract(const Duration(days: 7))
          .toIso8601String()
          .substring(0, 10);

      final response = await dio.get(
        _ApiPath.everything,
        queryParameters: {
          'q': query,
          'from': from,
          'sortBy': 'publishedAt',
          'page': page,
          'pageSize': pageSize,
          'apiKey': _ApiPath.apiKey,
        },
      );
      return NewsArticleModel.fromJsonList(response.data['articles']);
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map
          ? (data['message'] as String? ?? 'Server error')
          : (e.message ?? 'Server error');
      throw Exception(message);
    }
  }
} 
