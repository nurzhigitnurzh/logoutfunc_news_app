import 'package:home1/features/news/data/model/news_article_model.dart';

abstract interface class NewsDataSource {
  Future<List<NewsArticleModel>> getEverything(String query);
}