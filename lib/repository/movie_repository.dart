import 'package:sobatbisnis_assesment/model/model.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchPopularMovies();

  Future<List<Movie>> fetchUpcomingMovies();

  Future<List<Movie>> fetchTopRatedMovies();

  Future<List<Movie>> fetchNowPlayingMovies();
}
