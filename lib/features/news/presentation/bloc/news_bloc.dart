import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_news_headlines_usecase.dart';
import '../../domain/entities/news_article_entity.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsHeadlinesUseCase getNewsHeadlines;
  NewsBloc(this.getNewsHeadlines) : super(NewsInitial()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final articles = await getNewsHeadlines();
        emit(NewsLoaded(articles));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}
