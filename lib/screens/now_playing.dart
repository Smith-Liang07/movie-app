import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sobatbisnis_assesment/bloc/cubit/movie_cubit_cubit.dart';
import 'package:sobatbisnis_assesment/util/constant.dart';
import 'package:sobatbisnis_assesment/widget/movie_card.dart';
import 'package:sobatbisnis_assesment/widget/movie_container.dart';

class NowPlaying extends StatefulWidget {
  NowPlaying({Key? key}) : super(key: key);

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MovieCubitCubit>().fetchMovie(MovieType.NOW_PLAYING);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NOW PLAYING",
          style: kAppBarTitleStyle,
        ),
        backgroundColor: kAppBarColor,
      ),
      body: Center(
        child: BlocConsumer<MovieCubitCubit, MovieCubitState>(
          listener: (context, state) {
            if (state is RemoteMovieCubitLoaded) {
              context.read<MovieCubitCubit>().updateLocalMovieDatabase(
                  state.movies, MovieType.NOW_PLAYING);
            }
          },
          builder: (context, state) {
            if (state is MovieCubitInitial) {
              return SpinKitChasingDots(
                color: Colors.green,
              );
            }
            if (state is LocalMovieCubitLoaded) {
              var movieCards = List.generate(state.movies.length, (index) {
                return MovieCard(
                    movie: state.movies[index], themeColor: kPrimaryColor);
              });
              return MovieCardContainer(
                  themeColor: kPrimaryColor,
                  scrollController: _scrollController,
                  movieCards: movieCards);
            }
            if (state is RemoteMovieCubitLoaded) {
              var movieCards = List.generate(state.movies.length, (index) {
                return MovieCard(
                    movie: state.movies[index], themeColor: kPrimaryColor);
              });
              return MovieCardContainer(
                  themeColor: kPrimaryColor,
                  scrollController: _scrollController,
                  movieCards: movieCards);
            }
            if (state is MovieCubitError)
              return Center(child: Text(state.errMsg));
            return Container();
          },
        ),
      ),
    );
  }
}
