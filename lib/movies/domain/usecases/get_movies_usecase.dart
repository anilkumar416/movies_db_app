import 'package:dartz/dartz.dart';
import 'package:movies_db_app/core/data/error/failure.dart';
import 'package:movies_db_app/core/domain/entities/media.dart';
import 'package:movies_db_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_db_app/movies/domain/respository/movies_respository.dart';

class GetMoviesUseCase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final MoviesRespository _baseMoviesRespository;

  GetMoviesUseCase(this._baseMoviesRespository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _baseMoviesRespository.getMovies();
  }
}
