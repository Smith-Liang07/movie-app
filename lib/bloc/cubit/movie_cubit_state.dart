part of 'movie_cubit_cubit.dart';

@immutable
abstract class MovieCubitState {}

class MovieCubitInitial extends MovieCubitState {}

class MovieCubitLoaded extends MovieCubitState {
  final List<Movie> movies;
  final MovieType movieType;

  MovieCubitLoaded({required this.movies, required this.movieType});
}

class MovieCubitError extends MovieCubitState {
  final String errMsg;

  MovieCubitError({required this.errMsg});
}
