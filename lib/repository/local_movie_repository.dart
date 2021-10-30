import 'package:sobatbisnis_assesment/bloc/cubit/movie_cubit_cubit.dart';
import 'package:sobatbisnis_assesment/model/model.dart';
import 'package:sobatbisnis_assesment/repository/movie_repository.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sobatbisnis_assesment/helper/db_helper.dart';

class LocalMovieRepository extends MovieRepository {
  var databaseFuture = DatabaseHelper.db.database;
  static const MOVIE_POPULAR_TABLE_NAME = 'movie_popular';
  static const MOVIE_TOP_RATED_TABLE_NAME = 'movie_top_rated';
  static const MOVIE_COMING_SOON_TABLE_NAME = 'movie_coming_soon';
  static const MOVIE_NOW_PLAYING_TABLE_NAME = 'movie_now_playing';

  Future<List<Movie>> getAllMovies(MovieType movieType) async {
    late final String tableName;
    switch (movieType) {
      case MovieType.UPCOMING:
        tableName = MOVIE_COMING_SOON_TABLE_NAME;
        break;
      case MovieType.TOP_RATED:
        tableName = MOVIE_TOP_RATED_TABLE_NAME;
        break;
      case MovieType.NOW_PLAYING:
        tableName = MOVIE_NOW_PLAYING_TABLE_NAME;
        break;
      case MovieType.POPULAR:
      default:
        tableName = MOVIE_POPULAR_TABLE_NAME;
        break;
    }
    late final List<Movie> movieList;
    final Database database = await databaseFuture;
    final movieMap = await database.query(tableName);
    movieList = movieMap.map((movie) => Movie.fromMap(movie)).toList();
    return movieList;
  }

  Future<void> updateLocalMovieDatatable(
      List<Movie> movieList, MovieType movieType) async {
    late final String tableName;
    switch (movieType) {
      case MovieType.UPCOMING:
        tableName = MOVIE_COMING_SOON_TABLE_NAME;
        break;
      case MovieType.TOP_RATED:
        tableName = MOVIE_TOP_RATED_TABLE_NAME;
        break;
      case MovieType.NOW_PLAYING:
        tableName = MOVIE_NOW_PLAYING_TABLE_NAME;
        break;
      case MovieType.POPULAR:
      default:
        tableName = MOVIE_POPULAR_TABLE_NAME;
        break;
    }
    final Database database = await databaseFuture;
    Batch batch = database.batch();
    movieList.forEach((movie) async {
      batch.insert(
        tableName,
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
    batch.commit();
  }

  @override
  Future<List<Movie>> fetchNowPlayingMovies() async {
    return await getAllMovies(MovieType.NOW_PLAYING);
  }

  @override
  Future<List<Movie>> fetchPopularMovies() async {
    return await getAllMovies(MovieType.POPULAR);
  }

  @override
  Future<List<Movie>> fetchTopRatedMovies() async {
    return await getAllMovies(MovieType.TOP_RATED);
  }

  @override
  Future<List<Movie>> fetchUpcomingMovies() async {
    return await getAllMovies(MovieType.UPCOMING);
  }
}
