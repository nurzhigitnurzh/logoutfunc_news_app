import 'package:home1/features/news/domain/entity/news_article_entity.dart';

abstract interface class NewsRepository {
  Future<List<NewsArticleEntity>> getEverythingArticles(String query);
}