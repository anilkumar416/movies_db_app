import 'package:dartz/dartz.dart';
import 'package:movies_db_app/core/data/error/failure.dart';
import 'package:movies_db_app/core/domain/entities/media.dart';

abstract class MoviesRespository {
  Future<Either<Failure, List<List<Media>>>> getMovies();
  // Future<Either<Failure, MediaDetails>> getMovieDetails(int movieId);
  Future<Either<Failure, List<Media>>> getAllPopularMovies(int page);
  Future<Either<Failure, List<Media>>> getAllTopRatedMovies(int page);
}
