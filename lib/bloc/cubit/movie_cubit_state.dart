part of 'movie_cubit_cubit.dart';

@immutable
abstract class MovieCubitState {}

class MovieCubitInitial extends MovieCubitState {}

class RemoteMovieCubitLoaded extends MovieCubitState {
  final List<Movie> movies;
  final MovieType movieType;

  RemoteMovieCubitLoaded({required this.movies, required this.movieType});
}

class LocalMovieCubitLoaded extends MovieCubitState {
  final List<Movie> movies;
  final MovieType movieType;

  LocalMovieCubitLoaded({required this.movies, required this.movieType});
}

class MovieCubitError extends MovieCubitState {
  final String errMsg;

  MovieCubitError({required this.errMsg});
}
