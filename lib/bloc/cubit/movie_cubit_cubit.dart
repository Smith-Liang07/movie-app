import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity/connectivity.dart';

import 'package:sobatbisnis_assesment/model/movie_response.dart';
import 'package:sobatbisnis_assesment/repository/local_movie_repository.dart';
import 'package:sobatbisnis_assesment/repository/movie_repository.dart';
import 'package:sobatbisnis_assesment/repository/remote_movie_repository.dart';

part 'movie_cubit_state.dart';

enum MovieType {
  POPULAR,
  TOP_RATED,
  UPCOMING,
  NOW_PLAYING,
}

class MovieCubitCubit extends Cubit<MovieCubitState> {
  final RemoteMovieRepository remoteMovieRepository;
  final LocalMovieRepository localMovieRepository;
  late MovieRepository _repository;
  late ConnectivityResult _connectivityStatus;

  MovieCubitCubit(
      {required this.remoteMovieRepository, required this.localMovieRepository})
      : super(MovieCubitInitial());

  fetchMovie(MovieType movieType) async {
    late final response;
    final _connectivity = Connectivity();
    _connectivityStatus = await _connectivity.checkConnectivity();

    if (_connectivityStatus == ConnectivityResult.none) {
      _repository = localMovieRepository;
    } else {
      _repository = remoteMovieRepository;
    }
    emit(MovieCubitInitial());
    try {
      switch (movieType) {
        case MovieType.TOP_RATED:
          response = await _repository.fetchTopRatedMovies();
          // response = await localMovieRepository.getAllMovies(movieType);
          break;
        case MovieType.UPCOMING:
          response = await _repository.fetchUpcomingMovies();
          break;
        case MovieType.NOW_PLAYING:
          response = await _repository.fetchNowPlayingMovies();
          break;
        case MovieType.POPULAR:
        default:
          response = await _repository.fetchPopularMovies();
          break;
      }

      if (_connectivityStatus == ConnectivityResult.none) {
        emit(LocalMovieCubitLoaded(movies: response, movieType: movieType));
      } else {
        emit(RemoteMovieCubitLoaded(movies: response, movieType: movieType));
      }
    } catch (e) {
      emit(MovieCubitError(errMsg: e.toString()));
    }
  }

  Future<void> updateLocalMovieDatabase(
      List<Movie> movieList, MovieType movieType) async {
    try {
      await localMovieRepository.updateLocalMovieDatatable(
          movieList, movieType);
    } catch (error) {
      emit(MovieCubitError(errMsg: error.toString()));
    }
  }
}
