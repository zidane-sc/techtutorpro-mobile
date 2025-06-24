import 'package:equatable/equatable.dart';
import '../../domain/entities/news_article_entity.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticleEntity> articles;
  NewsLoaded(this.articles);
  @override
  List<Object?> get props => [articles];
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
  @override
  List<Object?> get props => [message];
}
