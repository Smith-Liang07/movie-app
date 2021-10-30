import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sobatbisnis_assesment/bloc/comment/cubit/comment_cubit.dart';
import 'package:sobatbisnis_assesment/util/constant.dart';
import 'package:sobatbisnis_assesment/widget/comment_modal.dart';
import 'package:sobatbisnis_assesment/util/star_generator.dart'
    as StarCalculator;

class MovieCommentsScreen extends StatefulWidget {
  MovieCommentsScreen({Key? key}) : super(key: key);

  @override
  _MovieCommentsScreenState createState() => _MovieCommentsScreenState();
}

class _MovieCommentsScreenState extends State<MovieCommentsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<CommentCubit>().fetchAllComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "COMMENTS",
          style: kAppBarTitleStyle,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          BlocConsumer<CommentCubit, CommentState>(
            builder: (context, state) {
              if (state is CommentInitial) {
                return SpinKitChasingDots(
                  color: kMainGreenColor,
                );
              }
              if (state is CommentLoaded) {
                return ListView.builder(
                    itemCount: state.comments.length,
                    itemBuilder: (ctx, index) {
                      final comment = state.comments[index];
                      return GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              context: context,
                              builder: (context) {
                                return CommentModal(
                                  comment: comment,
                                  update: true,
                                );
                              });
                        },
                        child: Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            context
                                .read<CommentCubit>()
                                .deleteComment(comment.id!);
                          },
                          background: Container(color: Colors.red),
                          child: ListTile(
                            title: Text(
                              comment.userName,
                              style: kDetailMovieTitleStyle,
                            ),
                            subtitle: Text(
                              comment.review,
                              style: kDetailMovieDescStyle,
                            ),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: StarCalculator.getStars(
                                    rating: comment.rating * 2,
                                    starSize: 15.sp)),
                            horizontalTitleGap: 2.0,
                          ),
                        ),
                      );
                    });
              }
              if (state is CommentError) {
                return Center(child: Text(state.errMsg));
              }
              return Container();
            },
            listener: (context, state) {},
          ),
          Positioned(
            right: 5.w,
            bottom: 5.h,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    context: context,
                    builder: (context) {
                      return CommentModal();
                    });
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
                        "Add Comment",
                        style:
                            kMovieCardTitleStyle.copyWith(color: kPrimaryColor),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.add_comment_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
