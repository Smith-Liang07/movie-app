part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoaded extends CommentState {
  final List<MovieComment> comments;

  CommentLoaded({required this.comments});
}

class CommentError extends CommentState {
  final String errMsg;

  CommentError({required this.errMsg});
}
