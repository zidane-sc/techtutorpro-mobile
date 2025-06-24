import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/injection.config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techtutorpro/features/news/data/datasources/news_remote_datasource.dart';
import 'package:techtutorpro/features/news/data/repositories/news_repository_impl.dart';
import 'package:techtutorpro/features/news/domain/usecases/get_news_headlines_usecase.dart';
import 'package:techtutorpro/features/news/domain/repositories/news_repository.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async {
  $initGetIt(getIt);
  // News feature dependencies
  getIt.registerLazySingleton<NewsRemoteDatasource>(
      () => NewsRemoteDatasource());
  getIt.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(getIt<NewsRemoteDatasource>()));
  getIt.registerLazySingleton<GetNewsHeadlinesUseCase>(
      () => GetNewsHeadlinesUseCase(getIt<NewsRepository>()));
}

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
