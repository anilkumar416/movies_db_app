import 'package:get_it/get_it.dart';
import 'package:movies_db_app/movies/data/datasource/movies_remote_data_source.dart';
import 'package:movies_db_app/movies/data/repository/movies_repository_impl.dart';
import 'package:movies_db_app/movies/domain/respository/movies_respository.dart';
import 'package:movies_db_app/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movies_db_app/movies/movies_bloc/movies_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    // Data source
    sl.registerLazySingleton<MoviesRemoteDataSource>(
        () => MoviesRemoteDataSourceImpl());

    // Repository
    sl.registerLazySingleton<MoviesRespository>(
        () => MoviesRepositoryImpl(sl()));

    // Use Cases
    sl.registerLazySingleton(() => GetMoviesUseCase(sl()));

    //bloc
    sl.registerFactory(() => MoviesBloc(sl()));
  }
}
