import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sobatbisnis_assesment/bloc/comment/cubit/comment_cubit.dart';

import 'package:sobatbisnis_assesment/model/model.dart';
import 'package:sobatbisnis_assesment/util/constant.dart';

class CommentModal extends StatefulWidget {
  final MovieComment? comment;
  final bool update;
  CommentModal({this.comment, this.update = false, Key? key}) : super(key: key);

  @override
  _CommentModalState createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  final _formKey = GlobalKey<FormState>();

  var _comment;

  @override
  void initState() {
    super.initState();
    _comment = widget.comment != null
        ? widget.comment!
        : MovieComment(userName: "", review: "", rating: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RatingBar.builder(
                initialRating: widget.comment?.rating ?? 1.0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                unratedColor: Colors.amber.shade100,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _comment.rating = rating;
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Name",
                style: kMovieCardTitleStyle.copyWith(color: kPrimaryColor),
              ),
              SizedBox(
                height: 1.h,
              ),
              TextFormField(
                style: kMovieCardTitleStyle.copyWith(color: kPrimaryColor),
                initialValue: widget.comment?.userName ?? "",
                decoration: InputDecoration(
                  hintText: "input name here...",
                  hintStyle: kMovieCardTitleStyle.copyWith(color: kLightGrey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "this field is required";
                  }
                  return null;
                },
                onChanged: (value) {
                  _comment.userName = value;
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Review",
                style: kMovieCardTitleStyle.copyWith(color: kPrimaryColor),
              ),
              SizedBox(
                height: 1.h,
              ),
              TextFormField(
                maxLines: 5,
                minLines: 5,
                initialValue: widget.comment?.review ?? "",
                keyboardType: TextInputType.multiline,
                style: kMovieCardTitleStyle.copyWith(color: kPrimaryColor),
                decoration: InputDecoration(
                  hintText: "write review here...",
                  hintStyle: kMovieCardTitleStyle.copyWith(color: kLightGrey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(5.0)),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  _comment.review = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "this field is required";
                  }
                  var words = value.split(' ');
                  if (words.length < 3) {
                    return "required min 3 words";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.update) {
                      context.read<CommentCubit>().updateComment(_comment);
                    } else {
                      context.read<CommentCubit>().createComment(_comment);
                    }
                    Get.back();
                  }
                },
                child: Text(widget.update ? "Update" : "Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
