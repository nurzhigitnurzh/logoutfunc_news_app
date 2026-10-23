import 'package:equatable/equatable.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class GetNewsEvent extends NewsEvent {
  const GetNewsEvent(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class LoadMoreNewsEvent extends NewsEvent {
  const LoadMoreNewsEvent();
}