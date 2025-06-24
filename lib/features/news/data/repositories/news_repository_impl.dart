import '../../domain/entities/news_article_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDatasource remoteDatasource;
  NewsRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<NewsArticleEntity>> getTechNews() {
    return remoteDatasource.fetchTechNews();
  }
}
