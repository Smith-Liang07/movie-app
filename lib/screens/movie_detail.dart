import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sobatbisnis_assesment/model/movie_response.dart';
import 'package:sobatbisnis_assesment/screens/comments_screen.dart';
import 'package:sobatbisnis_assesment/util/constant.dart';
import 'package:sizer/sizer.dart';
import 'package:sobatbisnis_assesment/util/star_generator.dart'
    as starCalculator;
import 'package:sobatbisnis_assesment/util/constant.dart';

class MovieDetailScreen extends StatefulWidget {
  final Color themeColor;
  final Movie movie;
  MovieDetailScreen({required this.themeColor, required this.movie});
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late List<Widget> stars;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    stars = starCalculator.getStars(
        rating: widget.movie.voteAverage.toDouble(), starSize: 15.sp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: kPrimaryColor,
                shadowColor: Colors.transparent,
                leading: Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                automaticallyImplyLeading: false,
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 33.0.h,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SafeArea(
                      child: Container(
                        height: 33.h,
                        child: SpinKitChasingDots(
                          color: widget.themeColor,
                        ),
                      ),
                    ),
                    imageUrl: "$kThemoviedbImageURL${widget.movie.posterPath}",
                    errorWidget: (context, url, error) => SafeArea(
                      child: Container(
                        height: 22.h,
                        child: SpinKitChasingDots(color: widget.themeColor),
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.h),
                          child: Wrap(
                            children: [
                              Text(
                                "${widget.movie.title} ",
                                style: kDetailMovieTitleStyle,
                              ),
                              Text(
                                widget.movie.releaseDate,
                                style: kDetailMovieTitleStyle,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.h),
                          child: Row(children: stars),
                        ),
                        SizedBox(height: 3.h),
                        SizedBox(height: 1.h),
                      ],
                    ),
                    if (widget.movie.overview != "")
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.h, vertical: 3.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 1.h,
                                  left: 1.h,
                                  bottom: 1.h,
                                ),
                                child: Container(
                                  child: Text("Description",
                                      style: kDetailMovieDescStyle),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 1.h,
                                      left: 1.h,
                                      top: 1.h,
                                      bottom: 4.h),
                                  child: Text(widget.movie.overview,
                                      style: kDetailMovieDescStyle),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            right: 5.w,
            bottom: 5.h,
            child: GestureDetector(
              onTap: () {
                Get.to(MovieCommentsScreen());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Comments",
                        style:
                            kMovieCardTitleStyle.copyWith(color: kPrimaryColor),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.comment,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
