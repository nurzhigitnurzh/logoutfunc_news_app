import 'package:equatable/equatable.dart';
import 'package:home1/features/news/domain/entity/news_article_entity.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  const NewsLoaded({
    required this.articles,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final List<NewsArticleEntity> articles;
  final bool hasReachedMax;
  final bool isLoadingMore;

  NewsLoaded copyWith({
    List<NewsArticleEntity>? articles,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return NewsLoaded(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [articles, hasReachedMax, isLoadingMore];
}

class NewsError extends NewsState {
  const NewsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}