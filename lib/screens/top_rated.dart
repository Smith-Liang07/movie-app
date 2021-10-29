import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sobatbisnis_assesment/bloc/cubit/movie_cubit_cubit.dart';
import 'package:sobatbisnis_assesment/util/constant.dart';
import 'package:sobatbisnis_assesment/widget/movie_card.dart';
import 'package:sobatbisnis_assesment/widget/movie_container.dart';

class TopRated extends StatefulWidget {
  TopRated({Key? key}) : super(key: key);

  @override
  _TopRatedState createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MovieCubitCubit>().fetchMovie(MovieType.TOP_RATED);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TOP RATED",
          style: kAppBarTitleStyle,
        ),
        backgroundColor: kAppBarColor,
      ),
      body: Center(
        child: BlocBuilder<MovieCubitCubit, MovieCubitState>(
          builder: (context, state) {
            if (state is MovieCubitInitial) {
              return SpinKitChasingDots(
                color: Colors.green,
              );
            }
            if (state is MovieCubitLoaded) {
              var movieCards = List.generate(state.movies.length, (index) {
                return MovieCard(
                    movie: state.movies[index], themeColor: kPrimaryColor);
              });
              return MovieCardContainer(
                  themeColor: kPrimaryColor,
                  scrollController: _scrollController,
                  movieCards: movieCards);
            }
            if (state is MovieCubitError) return Text(state.errMsg);
            return Container();
          },
        ),
      ),
    );
  }
}
