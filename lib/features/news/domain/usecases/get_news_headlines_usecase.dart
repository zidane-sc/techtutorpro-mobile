import '../entities/news_article_entity.dart';
import '../repositories/news_repository.dart';

class GetNewsHeadlinesUseCase {
  final NewsRepository repository;
  GetNewsHeadlinesUseCase(this.repository);

  Future<List<NewsArticleEntity>> call() {
    return repository.getTechNews();
  }
}
