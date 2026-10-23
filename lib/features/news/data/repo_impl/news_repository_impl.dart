import 'package:injectable/injectable.dart';
import 'package:home1/features/news/data/remote/api/news_data_source.dart';
import 'package:home1/features/news/domain/entity/news_article_entity.dart';
import 'package:home1/features/news/domain/repo/news_repository.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl({required this.dataSource});

  final NewsDataSource dataSource;

  @override
  Future<List<NewsArticleEntity>> getEverythingArticles(String query) async {
    final models = await dataSource.getEverything(query);
    return models.map((e) => e.fromModelToEntity()).toList();
  }
}