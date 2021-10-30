import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:sobatbisnis_assesment/model/movie_response.dart';
import 'package:sobatbisnis_assesment/screens/movie_detail.dart';
import 'package:sobatbisnis_assesment/util/star_generator.dart'
    as starCalculator;
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sobatbisnis_assesment/util/constant.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Color themeColor;
  final int? contentLoadedFromPage;

  MovieCard({
    required this.movie,
    required this.themeColor,
    this.contentLoadedFromPage,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars =
        starCalculator.getStars(rating: movie.voteAverage, starSize: 2.h);

    return GestureDetector(
      onTap: () {
        Get.to(MovieDetailScreen(themeColor: themeColor, movie: movie));
      },
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Stack(
          children: [
            Container(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.2.w),
                  child: CachedNetworkImage(
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Column(
                            children: [
                              Container(
                                height: 20.h,
                                child: SpinKitChasingDots(
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                      imageUrl: "$kThemoviedbImageURL${movie.posterPath}",
                      errorWidget: (context, url, error) => Column(
                            children: [
                              Container(
                                height: 20.h,
                                child: SpinKitChasingDots(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          )),
                ),
              ),
              height: 30.h,
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                color: Colors.black,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.w),
                      bottomRight: Radius.circular(5.w),
                    ),
                    color: kAppBarColor,
                    boxShadow: kBoxShadow,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text("${movie.title} ",
                                      style: kMovieCardTitleStyle),
                                  Text(
                                      (movie.releaseDate == "")
                                          ? ""
                                          : "(${movie.releaseDate})",
                                      style: kMovieCardDateStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.w),
                        if (stars.length != 0) Row(children: stars),
                        SizedBox(height: 1.w),
                        Text(
                          movie.overview,
                          style: kMovieCardDescStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
