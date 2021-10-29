import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sobatbisnis_assesment/model/movie_response.dart';
import 'package:sobatbisnis_assesment/repository/remote_movie_repository.dart';

part 'movie_cubit_state.dart';

enum MovieType {
  POPULAR,
  TOP_RATED,
  UPCOMING,
  NOW_PLAYING,
}

class MovieCubitCubit extends Cubit<MovieCubitState> {
  RemoteMovieRepository repository;
  MovieCubitCubit({required this.repository}) : super(MovieCubitInitial());

  fetchMovie(MovieType movieType) async {
    var response;
    emit(MovieCubitInitial());
    try {
      switch (movieType) {
        case MovieType.TOP_RATED:
          response = await repository.fetchTopRatedMovies();
          break;
        case MovieType.UPCOMING:
          response = await repository.fetchUpcomingMovies();
          break;
        case MovieType.NOW_PLAYING:
          response = await repository.fetchNowPlayingMovies();
          break;
        case MovieType.POPULAR:
        default:
          response = await repository.fetchPopularMovies();
          break;
      }

      emit(MovieCubitLoaded(movies: response, movieType: movieType));
    } catch (e) {
      emit(MovieCubitError(errMsg: e.toString()));
    }
  }
}
