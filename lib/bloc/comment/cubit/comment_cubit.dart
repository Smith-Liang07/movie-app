import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sobatbisnis_assesment/model/model.dart';
import 'package:sobatbisnis_assesment/repository/local_comment_repository.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final LocalCommentRepository commentRepository;

  CommentCubit({required this.commentRepository}) : super(CommentInitial());

  Future<void> fetchAllComments() async {
    try {
      emit(CommentInitial());
      var comments = await commentRepository.getAllComments();
      emit(CommentLoaded(comments: comments));
    } catch (e) {
      emit(CommentError(errMsg: e.toString()));
    }
  }

  Future<void> createComment(MovieComment comment) async {
    if (state is CommentLoaded) {
      try {
        var resp = await commentRepository.insert(comment);
        CommentLoaded prevState = state as CommentLoaded;
        var prevComments = prevState.comments;
        emit(CommentLoaded(comments: [resp, ...prevComments]));
      } catch (e) {
        emit(CommentError(errMsg: e.toString()));
      }
    }
  }

  Future<void> getComment(int id) async {
    try {
      await commentRepository.getComment(id);
    } catch (e) {
      emit(CommentError(errMsg: e.toString()));
    }
  }

  Future<void> deleteComment(int id) async {
    try {
      await commentRepository.delete(id);
      var comments = await commentRepository.getAllComments();
      emit(CommentLoaded(comments: comments));
    } catch (e) {
      emit(CommentError(errMsg: e.toString()));
    }
  }

  Future<void> updateComment(MovieComment comment) async {
    try {
      await commentRepository.update(comment);
      var comments = await commentRepository.getAllComments();
      emit(CommentLoaded(comments: comments));
    } catch (e) {
      emit(CommentError(errMsg: e.toString()));
    }
  }
}
