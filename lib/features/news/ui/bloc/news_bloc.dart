import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:home1/features/news/domain/repo/news_repository.dart';
import 'package:home1/features/news/ui/bloc/news_event.dart';
import 'package:home1/features/news/ui/bloc/news_state.dart';

@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required this.repository}) : super(const NewsInitial()) {
    on<GetNewsEvent>(_onGetNews, transformer: restartable());
    on<LoadMoreNewsEvent>(_onLoadMore, transformer: droppable());
  }

  static const _pageSize = 20;

  final NewsRepository repository;

  String _query = '';
  int _page = 1;
  int _requestId = 0;

  Future<void> _onGetNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    _query = event.query;
    _page = 1;
    _requestId++;

    emit(const NewsLoading());

    try {
      final articles = await repository.getEverythingArticles(
        _query,
        page: 1,
        pageSize: _pageSize,
      );
      emit(NewsLoaded(
        articles: articles,
        hasReachedMax: articles.length < _pageSize,
      ));
    } catch (e) {
      emit(NewsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onLoadMore(
    LoadMoreNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    final current = state;
    if (current is! NewsLoaded ||
        current.hasReachedMax ||
        current.isLoadingMore) {
      return;
    }

    final requestId = _requestId;
    final nextPage = _page + 1;

    emit(current.copyWith(isLoadingMore: true));

    try {
      final more = await repository.getEverythingArticles(
        _query,
        page: nextPage,
        pageSize: _pageSize,
      );
      // пока грузили, пользователь начал новый поиск — результат не нужен
      if (requestId != _requestId) return;

      _page = nextPage;
      emit(NewsLoaded(
        articles: [...current.articles, ...more],
        hasReachedMax: more.length < _pageSize,
      ));
    } catch (_) {
      if (requestId != _requestId) return;
      // бесплатный тариф NewsAPI отдаёт максимум 100 результатов,
      // дальше приходит ошибка — считаем, что список закончился
      emit(current.copyWith(isLoadingMore: false, hasReachedMax: true));
    }
  }
}